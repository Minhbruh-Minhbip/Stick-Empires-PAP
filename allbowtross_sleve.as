package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="allbowtross_sleve")]
   public dynamic class allbowtross_sleve extends MovieClip
   {
       
      
      public function allbowtross_sleve()
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
