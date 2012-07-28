package org.cloudladder.locomoco.utils
{
    import flash.errors.IllegalOperationError;
    import flash.net.registerClassAlias;
    import flash.utils.Dictionary;
    import flash.utils.describeType;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    /**
     * The ClassUtil class is static class with the function relevant to a class.
     *
     */
    public final class ClassUtil extends StaticClass
    {
        static private var _describeTypeCache:Dictionary = new Dictionary();
        static private var _classDefCache:Dictionary = new Dictionary();
        static private var _creators:Array =
        [
            _createInstance0,
            _createInstance1,
            _createInstance2,
            _createInstance3,
            _createInstance4,
            _createInstance5
        ];

        /**
         * Return a new Object.
         * @param klass
         * @param args
         * @return
         * @throws flash.errors.IllegalOperationError   exception is thrown when length of parameter 'args' was 6 or more length.
         */
        static public function createInstance(klass:Class, ... args):*
        {
            var classDef:Class = getClassDef(klass);
            const argsLength:int = ObjectUtil.getLength(args);
            if (argsLength >= _creators.length)
            {
                throw new IllegalOperationError("It does not correspond to six or more arguments.");
            }
            const creator:Function = _creators[argsLength];
            var creatorArgs:Array = ObjectUtil.valueToArray(args);
            creatorArgs.unshift(classDef);
            var instance:* = creator.apply(null, creatorArgs);
            return instance;
        }

        /**
         * Determinates whether a class is in child-parent relationship.
         * @param parent
         * @param source
         * @return
         *
         */
        static public function isInherited(parent:Class, source:Class):Boolean
        {
            const parentClassName:String = getQualifiedClassName(parent);
            const klassXML:XML = ClassUtil.describeType(source);
            var result:Boolean = false;
            for each (var child:XML in klassXML.factory.children())
            {
                if (child.name().localName != "extendsClass")
                {
                    continue;
                }
                if (child.@type == parentClassName)
                {
                    result = true;
                    break;
                }
                if (child.@type == "Object")
                {
                    break;
                }
            }
            return result;
        }

        /**
         * Return a XML which contains describe type. (Cash will be used if cash exists.)
         * @param source
         * @return
         *
         */
        static public function describeType(source:*):XML
        {
            var classDef:Class = getClassDef(source);
            return _describeTypeCache[classDef] ||= _describeType(classDef);
        }

        /**
         * Return a class definition.
         * @param source
         * @return
         *
         */
        static public function getClassDef(source:*):Class
        {
            var fullClassName:String = getQualifiedClassName(source);
            return _classDefCache[fullClassName] ||= _getClassDef(fullClassName) as Class;
        }

        /**
         * Register alias so that an instance can be saved in an AMF format.
         * @param source
         *
         */
        static public function registerClass(source:*):void
        {
            var fullClassName:String = getQualifiedClassName(source);
            var classDef:Class = _classDefCache[fullClassName] ||= _getClassDef(fullClassName);
            registerClassAlias(fullClassName, classDef);
        }

        /**
         * @private
         * @param classDef
         * @return
         *
         */
        static private function _describeType(classDef:Class):XML
        {
            return flash.utils.describeType(classDef);
        }

        /**
         * @private
         * @param fullClassName
         * @return
         *
         */
        static private function _getClassDef(fullClassName:String):Class
        {
            return getDefinitionByName(fullClassName) as Class;
        }

        /**
         * @private
         */
        static private function _createInstance0(klass:Class):*
        {
            return new klass();
        }

        /**
         * @private
         */
        static private function _createInstance1(klass:Class, arg1:*):*
        {
            return new klass(arg1);
        }

        /**
         * @private
         */
        static private function _createInstance2(klass:Class, arg1:*, arg2:*):*
        {
            return new klass(arg1, arg2);
        }

        /**
         * @private
         */
        static private function _createInstance3(klass:Class, arg1:*, arg2:*, arg3:*):*
        {
            return new klass(arg1, arg2, arg3);
        }

        /**
         * @private
         */
        static private function _createInstance4(klass:Class, arg1:*, arg2:*, arg3:*, arg4:*):*
        {
            return new klass(arg1, arg2, arg3, arg4);
        }

        /**
         * @private
         */
        static private function _createInstance5(klass:Class, arg1:*, arg2:*, arg3:*, arg4:*, arg5:*):*
        {
            return new klass(arg1, arg2, arg3, arg4, arg5);
        }
    }
}
