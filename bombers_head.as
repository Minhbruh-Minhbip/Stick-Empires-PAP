package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="bombers_head")]
   public dynamic class bombers_head extends MovieClip
   {
       
      
      public function bombers_head()
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
