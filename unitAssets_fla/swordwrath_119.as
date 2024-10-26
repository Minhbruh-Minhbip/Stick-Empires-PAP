package unitAssets_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="unitAssets_fla.swordwrath_119")]
   public dynamic class swordwrath_119 extends MovieClip
   {
       
      
      public var sword:itemSword;
      
      public var head:swordwrathHat;
      
      public function swordwrath_119()
      {
         super();
         addFrameScript(149,this.frame150);
      }
      
      internal function frame150() : *
      {
         gotoAndPlay(60);
      }
   }
}
