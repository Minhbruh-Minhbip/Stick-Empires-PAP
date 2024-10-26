package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="allbowtross_backwing")]
   public dynamic class allbowtross_backwing extends MovieClip
   {
       
      
      public function allbowtross_backwing()
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
