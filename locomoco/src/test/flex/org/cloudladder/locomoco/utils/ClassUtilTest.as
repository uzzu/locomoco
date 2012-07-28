package org.cloudladder.locomoco.utils
{
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.utils.ByteArray;
    import flash.utils.describeType;
    import flash.utils.getDefinitionByName;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertFalse;
    import org.flexunit.asserts.assertNotNull;
    import org.flexunit.asserts.assertTrue;
    import org.hamcrest.assertThat;
    import org.hamcrest.core.isA;

    public class ClassUtilTest
    {

        [Test]
        public function describeTypePublic():void
        {
            var sprite:Sprite = new Sprite();
            assertEquals(describeType(Sprite).toXMLString()
                , ClassUtil.describeType(sprite));
        }

        [Test]
        public function classDefPublic():void
        {
            var sprite:Sprite = new Sprite();
            var spriteFullname:String = "flash.display.Sprite";
            assertEquals(getDefinitionByName(spriteFullname)
                , ClassUtil.getClassDef(sprite));
        }

        [Test]
        public function registerClass():void
        {
            ClassUtil.registerClass(TextField);
            var regInput:TextField = new TextField();
            var bytes:ByteArray = new ByteArray();
            bytes.writeObject(regInput);
            bytes.position = 0;
            var regOutput:* = bytes.readObject();
            assertThat(regOutput, isA(TextField));
        }

        [Test]
        public function isInherited():void
        {
            assertTrue(ClassUtil.isInherited(DisplayObjectContainer, MovieClip));
            assertFalse(ClassUtil.isInherited(DisplayObjectContainer
                , TextField));
        }

        [Test]
        public function createInstanceNoArguments():void
        {
            var inst0:SomeArgumentsClassMock = ClassUtil.createInstance(SomeArgumentsClassMock);
            assertNotNull(inst0);
        }

        [Test]
        public function createInstanceArgument1():void
        {
            var inst1:SomeArgumentsClassMock = ClassUtil.createInstance(SomeArgumentsClassMock
                , 'h');
            assertNotNull(inst1);
            assertEquals(inst1.arg1, 'h');
        }

        [Test]
        public function createInstanceArgument2():void
        {
            var inst2:SomeArgumentsClassMock = ClassUtil.createInstance(SomeArgumentsClassMock
                , 'h', 'hh');
            assertNotNull(inst2);
            assertEquals(inst2.arg1, 'h');
            assertEquals(inst2.arg2, 'hh');
        }

        [Test]
        public function createInstanceArgument3():void
        {
            var inst3:SomeArgumentsClassMock = ClassUtil.createInstance(SomeArgumentsClassMock
                , 'h', 'hh', 'hhh');
            assertNotNull(inst3);
            assertEquals(inst3.arg1, 'h');
            assertEquals(inst3.arg2, 'hh');
            assertEquals(inst3.arg3, 'hhh');
        }

        [Test]
        public function createInstanceArgument4():void
        {
            var inst4:SomeArgumentsClassMock = ClassUtil.createInstance(SomeArgumentsClassMock
                , 'h', 'hh', 'hhh', 'hhhh');
            assertNotNull(inst4);
            assertEquals(inst4.arg1, 'h');
            assertEquals(inst4.arg2, 'hh');
            assertEquals(inst4.arg3, 'hhh');
            assertEquals(inst4.arg4, 'hhhh');
        }

        [Test]
        public function createInstanceArgument5():void
        {
            var inst5:SomeArgumentsClassMock = ClassUtil.createInstance(SomeArgumentsClassMock
                , 'h', 'hh', 'hhh', 'hhhh', 'hhhhh');
            assertNotNull(inst5);
            assertEquals(inst5.arg1, 'h');
            assertEquals(inst5.arg2, 'hh');
            assertEquals(inst5.arg3, 'hhh');
            assertEquals(inst5.arg4, 'hhhh');
            assertEquals(inst5.arg5, 'hhhhh');
        }

        [Test(expected="flash.errors.IllegalOperationError")]
        public function invalidArguments():void
        {
            ClassUtil.createInstance(SomeArgumentsClassMock, 'h', 'hh'
                , 'hhh', 'hhhh', 'hhhhh', 'hhhhhh', 'hhhhhhh', 'hhhhhhhh'
                , 'hhhhhhhhhh');
        }
    }
}
