package org.cloudladder.locomoco
{
    import flash.utils.Dictionary;
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;
    import flash.utils.getQualifiedClassName;

    import mx.binding.utils.ChangeWatcher;

    import org.cloudladder.locomoco.utils.ClassUtil;

    /**
     * The Context class is a base class of all the Context when using locomoco-framework
     */
    public dynamic class Context extends Proxy
    {
        /**
         * @private
         */
        protected var _watchers:Dictionary /* of Dictionary ( of mx.binding.utils.ChangeWatcher ) */;

        /**
         * @private
         */
        private var _contexts:Dictionary /* of org.cloudladder.Context */ = new Dictionary();

        /**
         * Create a new Context Object.
         */
        public function Context()
        {
            _watchers = new Dictionary();
            _contexts = new Dictionary();
        }

        /**
         * @inheritDoc
         */
        public function toString():String
        {
            return getQualifiedClassName(this);
        }

        /**
         * Return a Context Object.
         * @param contextClass
         * @return
         */
        public function get(contextClass:Class):*
        {
            if (_contexts[contextClass])
            {
                return _contexts[contextClass];
            }
            if (!ClassUtil.isInherited(Context, contextClass))
            {
                throw new LocomocoError("The class has not inherited '" + getQualifiedClassName(Context) + "' is unable to create.");
            }
            _contexts[contextClass] = ClassUtil.createInstance(contextClass);
            Context(_contexts[contextClass]).initialize();
            return _contexts[contextClass];
        }

        /**
         * Remove a Context Object.
         * @param contextClass
         */
        public function remove(contextClass:Class):void
        {
            if (_contexts[contextClass])
            {
                Context(_contexts[contextClass]).finalize();
            }
            _contexts[contextClass] = null;
        }

        /**
         * This method is called when Context#get() instruction execution time and the specified instance are generated for the first time.
         */
        public function initialize():void
        {
        }

        /**
         * This method is called for the instruction execution time of Context#remove() before deletion of an object.
         */
        public function finalize():void
        {
            unbindAll();
        }

        /**
         * Unbind changing all property of Context.
         */
        public function unbindAll():void
        {
            for each (var props:Dictionary in _watchers)
            {
                for each (var watcher:* in props)
                {
                    if (watcher is ChangeWatcher)
                        watcher.unwatch();
                }
            }
            _watchers = null;
        }

        /**
         * @throws  org.cloudladder.locomoco.LocomocoError exception is thrown when this method was called.
         */
        flash_proxy override function getProperty(name:*):*
        {
            throw new LocomocoError("undefined property: " + name);
        }

        /**
         * @throws  org.cloudladder.locomoco.LocomocoError exception is thrown when this method was called.
         */
        flash_proxy override function setProperty(name:*, value:*):void
        {
            throw new LocomocoError("undefined property: " + name);
        }

        /**
         * @inheritDoc
         * @param name          <p>bind{PropertyName} - Bind changing property of Context.</p>
         *                      <p>unbind{PropertyName} - Unbind changing property of Context.</p>
         * @param parameters    [0] - callback function.
         * @return
         * @throws org.cloudladder.locomoco.LocomocoError   exception is thrown when functions for other than 'bind*' and 'unbind*' are specified.
         */
        flash_proxy override function callProperty(name:*, ... parameters):*
        {
            var bindPropertyResults:Object = /^bind(.+)$/.exec(name);
            var unbindPropertyResults:Object = /^unbind(.+)$/.exec(name);
            if (bindPropertyResults)
            {
                if (!(parameters[0] is Function))
                {
                    throw new LocomocoError("argument is not Function.");
                }
                var bindProperty:String = bindPropertyResults[1];
                bindProperty = bindProperty.charAt(0).toLowerCase() + bindProperty.substring(1);
                var watcher:ChangeWatcher = ChangeWatcher.watch(this, bindProperty, parameters[0] as Function);
                if (!_watchers[bindProperty])
                {
                    _watchers[bindProperty] = new Dictionary();
                }
                _watchers[bindProperty][parameters[0]] = watcher;
                return;
            }
            if (unbindPropertyResults)
            {
                if (!(parameters[0] is Function))
                {
                    throw new LocomocoError("argument is not Function.");
                }
                var unbindProperty:String = unbindPropertyResults[1];
                unbindProperty = unbindProperty.charAt(0).toLowerCase() + unbindProperty.substring(1);
                if (!_watchers[unbindProperty])
                {
                    return;
                }
                if (_watchers[unbindProperty][parameters[0]])
                {
                    ChangeWatcher(_watchers[unbindProperty][parameters[0]]).unwatch();
                    _watchers[unbindProperty][parameters[0]] = null;
                }
                return;
            }
            throw new LocomocoError("undefined function: " + name);
        }
    }
}
