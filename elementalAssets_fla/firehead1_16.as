package elementalAssets_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="elementalAssets_fla.firehead1_16")]
   public dynamic class firehead1_16 extends MovieClip
   {
       
      
      public var firered:MovieClip;
      
      public var hat:_fireHat;
      
      public var glare:MovieClip;
      
      public function firehead1_16()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
