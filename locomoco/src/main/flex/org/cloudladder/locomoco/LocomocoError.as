package org.cloudladder.locomoco
{
    /**
     * The LocomocoError exception is thrown when doesn't cover the framework usage.
     */
    public class LocomocoError extends Error
    {
        /**
         * Create a new LocomocoError Object.
         */
        public function LocomocoError(message:String = "", id:int = 0)
        {
            super(message, id);
        }
    }
}
