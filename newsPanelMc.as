package
{
   import fl.containers.ScrollPane;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="newsPanelMc")]
   public dynamic class newsPanelMc extends MovieClip
   {
       
      
      public var scrollPane:ScrollPane;
      
      public var title:TextField;
      
      public var dateBox:TextField;
      
      public function newsPanelMc()
      {
         super();
      }
   }
}
