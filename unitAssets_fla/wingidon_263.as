package unitAssets_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="unitAssets_fla.wingidon_263")]
   public dynamic class wingidon_263 extends MovieClip
   {
       
      
      public var wings:MovieClip;
      
      public var quiver:eclipsor_sleve;
      
      public var head:eclipsor_head;
      
      public var arms:MovieClip;
      
      public function wingidon_263()
      {
         super();
         addFrameScript(49,this.frame50);
      }
      
      internal function frame50() : *
      {
         stop();
      }
   }
}
