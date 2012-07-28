package org.cloudladder.locomoco.utils
{

    public class SomeArgumentsClassMock
    {
        public var arg1:*;
        public var arg2:*;
        public var arg3:*;
        public var arg4:*;
        public var arg5:*;
        public var arg6:*;
        public var arg7:*;
        public var arg8:*;
        public var arg9:*;
        public var arg10:*;

        public function SomeArgumentsClassMock(arg1:* = null
            , arg2:* = null, arg3:* = null, arg4:* = null, arg5:* = null
            , arg6:* = null, arg7:* = null, arg8:* = null, arg9:* = null
            , arg10:* = null)
        {
            this.arg1 = arg1;
            this.arg2 = arg2;
            this.arg3 = arg3;
            this.arg4 = arg4;
            this.arg5 = arg5;
            this.arg6 = arg6;
            this.arg7 = arg7;
            this.arg8 = arg8;
            this.arg9 = arg9;
            this.arg10 = arg10;
        }

        public function dump():void
        {
            trace('arg1', this.arg1);
            trace('arg2', this.arg2);
            trace('arg3', this.arg3);
            trace('arg4', this.arg4);
            trace('arg5', this.arg5);
            trace('arg6', this.arg6);
            trace('arg7', this.arg7);
            trace('arg8', this.arg8);
            trace('arg9', this.arg9);
            trace('arg10', this.arg10);
        }
    }
}
