package org.cloudladder.locomoco.utils
{
    import flash.errors.IllegalOperationError;

    /**
     * The StaticClass class define that it is a static class.
     */
    public class StaticClass
    {
        /**
         * @private
         * @throws  flash.errors.IllegalOperationError exception is thrown when going to create a new StaticClass object.
         */
        public function StaticClass()
        {
            throw new IllegalOperationError("static class.");
        }
    }
}
