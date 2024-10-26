package de.polygonal.ds
{
   import flash.Boot;
   
   public class Array2Iterator implements Itr
   {
       
      
      public var _s:int;
      
      public var _i:int;
      
      public var _f:Array2;
      
      public var _a:Array;
      
      public function Array2Iterator(param1:Array2 = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _f = param1;
         _a = _f._a;
         var _loc2_:* = _f;
         _s = int(_loc2_._w) * int(_loc2_._h);
         _i = 0;
         this;
      }
      
      public function reset() : Itr
      {
         _a = _f._a;
         var _loc1_:* = _f;
         _s = int(_loc1_._w) * int(_loc1_._h);
         _i = 0;
         return this;
      }
      
      public function next() : Object
      {
         var _loc1_:int;
         _i = (_loc1_ = _i) + 1;
         return _a[_loc1_];
      }
      
      public function hasNext() : Boolean
      {
         return _i < _s;
      }
      
      public function __size(param1:Object) : int
      {
         return int(param1._w) * int(param1._h);
      }
      
      public function __a(param1:Object) : Array
      {
         return param1._a;
      }
   }
}
