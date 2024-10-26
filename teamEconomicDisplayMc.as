package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="teamEconomicDisplayMc")]
   public dynamic class teamEconomicDisplayMc extends MovieClip
   {
       
      
      public var population:TextField;
      
      public var gold:TextField;
      
      public var mana:TextField;
      
      public function teamEconomicDisplayMc()
      {
         super();
      }
   }
}
