package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="ninja_head")]
   public dynamic class ninja_head extends MovieClip
   {
       
      
      public function ninja_head()
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
