package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="inGameMessageBoxMc")]
   public dynamic class inGameMessageBoxMc extends MovieClip
   {
       
      
      public var step:TextField;
      
      public var tick:MovieClip;
      
      public var text:TextField;
      
      public function inGameMessageBoxMc()
      {
         super();
      }
   }
}
