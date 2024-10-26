package elementalAssets_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="elementalAssets_fla.waterhead1_38")]
   public dynamic class waterhead1_38 extends MovieClip
   {
       
      
      public var hat:_waterHat;
      
      public var water:MovieClip;
      
      public var glare:MovieClip;
      
      public function waterhead1_38()
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
