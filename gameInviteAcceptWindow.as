package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="gameInviteAcceptWindow")]
   public dynamic class gameInviteAcceptWindow extends MovieClip
   {
       
      
      public var okButton:SimpleButton;
      
      public var invitationText:TextField;
      
      public var acceptButton:SimpleButton;
      
      public var rejectButton:SimpleButton;
      
      public function gameInviteAcceptWindow()
      {
         super();
      }
   }
}
