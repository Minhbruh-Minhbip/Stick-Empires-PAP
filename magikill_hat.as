package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="magikill_hat")]
   public dynamic class magikill_hat extends MovieClip
   {
       
      
      public function magikill_hat()
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
