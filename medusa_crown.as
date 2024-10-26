package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="medusa_crown")]
   public dynamic class medusa_crown extends MovieClip
   {
       
      
      public function medusa_crown()
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
