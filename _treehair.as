package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="_treehair")]
   public dynamic class _treehair extends MovieClip
   {
       
      
      public function _treehair()
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
