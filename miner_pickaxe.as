package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="miner_pickaxe")]
   public dynamic class miner_pickaxe extends MovieClip
   {
       
      
      public function miner_pickaxe()
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
