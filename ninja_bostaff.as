package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="ninja_bostaff")]
   public dynamic class ninja_bostaff extends MovieClip
   {
       
      
      public function ninja_bostaff()
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
