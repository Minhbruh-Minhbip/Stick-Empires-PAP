package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="allbowtross_head")]
   public dynamic class allbowtross_head extends MovieClip
   {
       
      
      public function allbowtross_head()
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
