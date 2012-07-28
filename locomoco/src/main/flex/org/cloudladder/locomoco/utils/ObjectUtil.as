package org.cloudladder.locomoco.utils
{
    /**
     * The ObjectUtil class is static class with the function relevant to a Object.
     */
    public final class ObjectUtil extends StaticClass
    {
        /**
         * Return a array which contains key of Object.
         * @param   object
         * @return
         */
        static public function keyToArray(object:Object):Array
        {
            var results:Array = [];
            for (var p:String in object)
            {
                results.push(p);
            }
            return results;
        }

        /**
         * Return a array which contains value of Object.
         * @param   object
         * @return
         */
        static public function valueToArray(object:Object):Array
        {
            var results:Array = [];
            for each (var params:* in object)
            {
                results.push(params);
            }
            return results;
        }

        /**
         * Return a value of length of Object
         * @param   object
         */
        static public function getLength(object:Object):int
        {
            var result:int = 0;
            for each (var param:* in object)
            {
                ++result;
            }
            return result;
        }
    }
}
