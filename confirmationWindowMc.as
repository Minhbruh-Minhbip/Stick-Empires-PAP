package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="confirmationWindowMc")]
   public dynamic class confirmationWindowMc extends MovieClip
   {
       
      
      public var invitationText:TextField;
      
      public var acceptButton:SimpleButton;
      
      public var rejectButton:SimpleButton;
      
      public function confirmationWindowMc()
      {
         super();
      }
   }
}
