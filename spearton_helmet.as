package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="spearton_helmet")]
   public dynamic class spearton_helmet extends MovieClip
   {
       
      
      public function spearton_helmet()
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
