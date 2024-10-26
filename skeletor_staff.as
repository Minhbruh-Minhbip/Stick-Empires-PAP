package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="skeletor_staff")]
   public dynamic class skeletor_staff extends MovieClip
   {
       
      
      public function skeletor_staff()
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
