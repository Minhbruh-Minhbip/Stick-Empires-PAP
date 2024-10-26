package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="spearton_spear")]
   public dynamic class spearton_spear extends MovieClip
   {
       
      
      public function spearton_spear()
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
