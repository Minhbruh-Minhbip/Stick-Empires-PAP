package com.brockw.stickwar.engine.multiplayer
{
   import com.brockw.stickwar.*;
   import com.smartfoxserver.v2.entities.data.*;
   import com.smartfoxserver.v2.requests.*;
   import com.smartfoxserver.v2.requests.buddylist.*;
   import fl.controls.*;
   import flash.events.*;
   import flash.text.*;
   
   public class BuddyChatTab extends buddyChatMc
   {
       
      
      public var id:int;
      
      private var _isMinimized:Boolean;
      
      internal var main:Main;
      
      private var _buddy:Buddy;
      
      public function BuddyChatTab(param1:int, param2:Main)
      {
         var _loc4_:Object = null;
         super();
         this.main = param2;
         this._isMinimized = false;
         this.id = param1;
         this.chatWindow.visible = true;
         this.chatWindow.chatInput.addEventListener(Event.CHANGE,this.sendChatMessage);
         this.chatWindow.chatInput.text = "";
         var _loc3_:StyleSheet = new StyleSheet();
         (_loc4_ = new Object()).color = "#FFB400";
         _loc3_.setStyle(".myText",_loc4_);
         (_loc4_ = new Object()).color = "#FFFFFF";
         _loc3_.setStyle(".theirText",_loc4_);
         this.chatWindow.chatOutput.styleSheet = _loc3_;
         this.chatWindow.chatOutput.htmlText = "";
         this.chatWindow.chatOutput.text = "";
         this.buddyText.mouseEnabled = false;
         this.buddy = null;
         this.chatWindow.chatOutput.mouseWheelEnabled = false;
         this.chatWindow.scroll.source = this.chatWindow.chatOutput;
         this.chatWindow.scroll.setSize(this.chatWindow.scroll.width,this.chatWindow.scroll.height);
         this.chatWindow.scroll.verticalScrollPolicy = ScrollPolicy.AUTO;
         this.chatWindow.scroll.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.chatWindow.scroll.update();
         chatWindow.blockingFrame.mouseEnabled = false;
         chatWindow.blockingFrame.mouseChildren = false;
         chatWindow.sendButton.addEventListener(MouseEvent.CLICK,this.sendChat,false,0,true);
      }
      
      public static function stripHTML(param1:String) : String
      {
         return param1.replace(":cyn:","<img src=\"https://media.discordapp.net/attachments/884832898153332806/1227685188184571944/plushiecyn.gif?ex=66294dee&is=6616d8ee&hm=2120d03e45f0d5c4af56f62d8ce659bc680260e3ab788fedc5c317c4a8a18f21&=&width=50&height=64\">‍\n‍\n‍\n‍\n‍\n‍").replace(":bitches:","<img src=\"https://media.discordapp.net/attachments/884832898153332806/1227685186574094346/bitches.gif?ex=66294ded&is=6616d8ed&hm=e14dcacfda5168b7c0066206cc418d3813a7244eb795f5d5867efad9482fc581&=&width=64&height=64\">‍\n‍\n‍\n‍\n‍\n‍").replace(":brain:","<img src=\"https://media.discordapp.net/attachments/884832898153332806/1227685186985132153/brain.gif?ex=66294ded&is=6616d8ed&hm=5743f31c6767f57b62fe3a1243094e1339325444a9e259503b565e5c5a9c4382&=&width=64&height=64\">‍\n‍\n‍\n‍\n‍\n‍").replace(":yoink:","<img src=\"https://media.discordapp.net/attachments/884832898153332806/1227685186188214272/yoink.gif?ex=66294ded&is=6616d8ed&hm=f3d9eb810f4c937de81c1878b2ed25b52d01be1c779554955810f794572fa7bf&=&width=64&height=62\">‍\n‍\n‍\n‍\n‍\n‍").replace(":hug:","<img src=\"https://media.discordapp.net/attachments/884832898153332806/1227685187333128213/hug.gif?ex=66294ded&is=6616d8ed&hm=a4e3729c8925dec74cf4685ee7d5248595788b44f026113c54fa3dd6b55d68df&=&width=64&height=64\">‍\n‍\n‍\n‍\n‍\n‍").replace(":pain:","<img src=\"https://media.discordapp.net/attachments/884832898153332806/1227685187765276682/pain.gif?ex=66294dee&is=6616d8ee&hm=5a9af38ceaccab563bbff0407003cbe6d13aa88132a2d1ed449c2c567a22cd1d&=&width=59&height=64\">‍\n‍\n‍\n‍\n‍\n‍").replace(":poop:","<img src=\"https://media.discordapp.net/attachments/788003893288108032/1228026015280795658/poopo.gif?ex=662a8b59&is=66181659&hm=4ba46fdaa0be0a97058c1092b424fe5a7d0278daa02e8d87774761e4ab82c620&=&width=67&height=64\">‍\n‍\n‍\n‍\n‍\n‍");
      }
      
      public function strReplace(str:String, search:String, replace:String) : String
      {
         return str.split(search).join(replace);
      }
      
      public function emojiNation(param1:String) : String
      {
         return param1;
      }
      
      public function receiveChat(param1:String, param2:String) : void
      {
         param2 = emojiNation(param2);
         if(this.id != 4083715)
         {
            param2 = stripHTML(param2);
            if(param1 == this.main.sfs.mySelf.name)
            {
               chatWindow.chatOutput.htmlText += "<span class=\'myText\'>" + param1 + ": " + param2 + "</span><br>";
            }
            else
            {
               chatWindow.chatOutput.htmlText += "<span class=\'theirText\'>" + param1 + ": " + param2 + "</span><br>";
            }
         }
         else if(this.id == 4083715)
         {
            if(param1 == this.main.sfs.mySelf.name)
            {
               chatWindow.chatOutput.htmlText += "<span class=\'myText\'>" + param1 + "|: " + param2 + "</span><br>";
            }
            if(param1 != this.main.sfs.mySelf.name)
            {
               chatWindow.chatOutput.htmlText += "<span class=\'theirText\'>" + param2 + "</span><br>";
            }
         }
         this.updateChatScroll();
      }
      
      public function updateChatScroll() : void
      {
         chatWindow.chatOutput.height = chatWindow.chatOutput.textHeight + 20;
         chatWindow.autoSize = "left";
         chatWindow.wordWrap = true;
         chatWindow.scroll.update();
         if(this.main.getOverlayScreen() == "chatOverlay")
         {
            chatWindow.scroll.verticalScrollPosition = chatWindow.chatOutput.height;
         }
      }
      
      public function minimize() : void
      {
         this.chatWindow.visible = false;
         this._isMinimized = true;
      }
      
      public function toggleChat() : void
      {
         if(this._isMinimized)
         {
            this.chatWindow.visible = true;
         }
         else
         {
            this.chatWindow.visible = false;
         }
         this._isMinimized = !this._isMinimized;
         if(!this._isMinimized)
         {
            stage.focus = chatWindow.chatInput;
         }
      }
      
      private function sendChat(param1:Event) : void
      {
         chatWindow.chatInput.text += "\n";
         this.sendChatMessage(param1);
      }
      
      private function sendChatMessage(param1:Event) : void
      {
         var _loc3_:SFSObject = null;
         var _loc2_:String = emojiNation(chatWindow.chatInput.text);
         if(_loc2_.charCodeAt(_loc2_.length - 1) == 13)
         {
            _loc2_ = _loc2_.slice(0,_loc2_.length - 1);
            if(_loc2_ == "" || _loc2_.charAt(0) == "\n" || _loc2_.charAt(0) == "\r")
            {
               chatWindow.chatInput.text = "";
               return;
            }
            _loc3_ = new SFSObject();
            _loc3_.putInt("id",this.id);
            _loc3_.putUtfString("m",_loc2_);
            _loc3_.putUtfString("n",this.main.sfs.mySelf.name);
            this.main.sfs.send(new ExtensionRequest("buddyChat",_loc3_));
            this.chatWindow.chatInput.text = "";
         }
      }
      
      public function get buddy() : Buddy
      {
         return this._buddy;
      }
      
      public function set buddy(param1:Buddy) : void
      {
         this._buddy = param1;
      }
   }
}
