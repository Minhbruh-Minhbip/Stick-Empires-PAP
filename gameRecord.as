package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="gameRecord")]
   public dynamic class gameRecord extends MovieClip
   {
       
      
      public var gameType:MovieClip;
      
      public var userA:TextField;
      
      public var replayButton:MovieClip;
      
      public var userB:TextField;
      
      public var winOrLoss:MovieClip;
      
      public var userAButton:MovieClip;
      
      public var raceTypeA:MovieClip;
      
      public var userBButton:MovieClip;
      
      public var raceTypeB:MovieClip;
      
      public var shareButton:MovieClip;
      
      public function gameRecord()
      {
         super();
      }
   }
}
