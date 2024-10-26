package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="skeletor_head")]
   public dynamic class skeletor_head extends MovieClip
   {
       
      
      public function skeletor_head()
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
