package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="knight_helmet")]
   public dynamic class knight_helmet extends MovieClip
   {
       
      
      public function knight_helmet()
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
