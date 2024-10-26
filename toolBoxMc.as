package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="toolBoxMc")]
   public dynamic class toolBoxMc extends MovieClip
   {
       
      
      public var elements:MovieClip;
      
      public var textBox:MovieClip;
      
      public var title:TextField;
      
      public var statDisplay:MovieClip;
      
      public function toolBoxMc()
      {
         super();
      }
   }
}
