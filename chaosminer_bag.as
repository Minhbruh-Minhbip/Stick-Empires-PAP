package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="chaosminer_bag")]
   public dynamic class chaosminer_bag extends MovieClip
   {
       
      
      public function chaosminer_bag()
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
