package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="swordwrathHat")]
   public dynamic class swordwrathHat extends MovieClip
   {
       
      
      public function swordwrathHat()
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
