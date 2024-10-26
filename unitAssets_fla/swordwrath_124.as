package unitAssets_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="unitAssets_fla.swordwrath_124")]
   public dynamic class swordwrath_124 extends MovieClip
   {
       
      
      public var sword:itemSword;
      
      public var head:swordwrathHat;
      
      public function swordwrath_124()
      {
         super();
         addFrameScript(53,this.frame54);
      }
      
      internal function frame54() : *
      {
         stop();
      }
   }
}
