package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="clanRequestAcceptWindowMc")]
   public dynamic class clanRequestAcceptWindowMc extends MovieClip
   {
       
      
      public var invitationText:TextField;
      
      public var closeButton:SimpleButton;
      
      public var acceptButton:SimpleButton;
      
      public var rejectButton:SimpleButton;
      
      public function clanRequestAcceptWindowMc()
      {
         super();
      }
   }
}
