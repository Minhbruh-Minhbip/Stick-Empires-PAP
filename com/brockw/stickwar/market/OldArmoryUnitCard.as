package com.brockw.stickwar.market
{
   import com.brockw.game.*;
   import com.brockw.stickwar.Main;
   import com.brockw.stickwar.engine.units.*;
   import com.smartfoxserver.v2.entities.data.*;
   import com.smartfoxserver.v2.requests.*;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.utils.*;
   
   public class OldArmoryUnitCard extends oldArmoryUnitCardMc
   {
      
      private static var hasChanged:Boolean = false;
       
      
      private var _unitMc:MovieClip;
      
      private var team:int;
      
      private var unitClass:Class;
      
      private var _unitType:int;
      
      private var _currentItemType:int;
      
      private var _main:Main;
      
      private var _isSelected:Boolean;
      
      private var _currentItems:Array;
      
      private var profileMc:MovieClip;
      
      private var itemPositionX:Number;
      
      private var itemPositionXReal:Number;
      
      private var hoverOverCard:Boolean;
      
      public var itemMap:Dictionary;
      
      private var _viewingIndex:int;
      
      private var lastSentCount:int;
      
      public function OldArmoryUnitCard(param1:Main, param2:int, param3:int, param4:MovieClip, param5:Class, param6:MovieClip)
      {
         super();
         this.main = param1;
         this.unitType = param3;
         this.team = param2;
         this._unitMc = param4;
         this.addChild(param6);
         this.profileMc = param6;
         param6.x = 79.5;
         param6.y = 72;
         this.itemPositionXReal = this.itemPositionX = 0;
         this.unitClass = param5;
         this.currentItemType = MarketItem.T_WEAPON;
         x += width / 2;
         y += height / 2;
         this.isSelected = false;
         this.unitName.visible = false;
         this.currentItems = [];
         this.setNotSelected();
         this._unitMc.scaleX *= -1;
         this.hoverOverCard = false;
         this.changeItemList();
         this.itemMap = new Dictionary();
         this.itemMap[MarketItem.T_WEAPON] = "";
         this.itemMap[MarketItem.T_ARMOR] = "";
         this.itemMap[MarketItem.T_MISC] = "";
         this.addEventListener(MouseEvent.CLICK,this.click);
         leftArrow.addEventListener(MouseEvent.CLICK,this.leftArrowClick,false,0,true);
         rightArrow.addEventListener(MouseEvent.CLICK,this.rightArrowClick,false,0,true);
         this.viewingIndex = 0;
         this.lastSentCount = 1000;
      }
      
      private function leftArrowClick(param1:Event) : void
      {
         this.viewingIndex -= 2;
         this.viewingIndex = Math.max(this.viewingIndex,0);
      }
      
      private function rightArrowClick(param1:Event) : void
      {
         this.viewingIndex += 2;
         this.viewingIndex = Math.min(this.currentItems.length - 4,this.viewingIndex);
         this.viewingIndex = Math.max(this.viewingIndex,0);
      }
      
      public function cleanUp() : void
      {
         var _loc1_:MarketItem = null;
         this.removeEventListener(MouseEvent.CLICK,this.click);
         leftArrow.removeEventListener(MouseEvent.CLICK,this.leftArrowClick);
         rightArrow.removeEventListener(MouseEvent.CLICK,this.rightArrowClick);
         for each(_loc1_ in this.currentItems)
         {
            if(this.displayContainer.contains(_loc1_))
            {
               displayContainer.removeChild(_loc1_);
            }
            _loc1_.cleanUp();
         }
      }
      
      public function click(param1:MouseEvent) : void
      {
      }
      
      public function unlockPrompt(param1:int, param2:int, param3:String) : void
      {
      }
      
      public function equip(param1:int, param2:int, param3:String) : void
      {
         this.main.loadout.setItem(param1,param2,param3);
         this.updateUnitProfile();
         this.main.armourScreen.saveLoadout();
         this.main.soundManager.playSoundFullVolume("ArmoryEquipSound");
      }
      
      public function setUnitProfile(param1:MovieClip) : void
      {
         if(!param1.contains(this._unitMc))
         {
            param1.addChild(this._unitMc);
         }
         this._unitMc.x = 0;
         this._unitMc.y = 0;
         this.updateUnitProfile();
      }
      
      public function updateUnitProfile() : void
      {
         if(this._unitMc.parent != null)
         {
            Util.animateMovieClip(this._unitMc,0);
            ItemMap.setItemsForUnitType(this.unitType,this._unitMc,this.itemMap[MarketItem.T_WEAPON],this.itemMap[MarketItem.T_ARMOR],this.itemMap[MarketItem.T_MISC]);
            if(this.unitType == Unit.U_MINER_ELEMENT)
            {
               this._unitMc.mc.crabgold.gotoAndStop(100);
            }
         }
      }
      
      public function removeUnitProfile(param1:MovieClip) : void
      {
         if(param1.contains(this._unitMc))
         {
            param1.removeChild(this._unitMc);
         }
      }
      
      public function changeType(param1:int) : void
      {
         this.viewingIndex = 0;
         if(this.currentItemType != param1)
         {
            this.currentItemType = param1;
         }
      }
      
      private function sortOnCost(param1:MarketItem, param2:MarketItem) : int
      {
         return param1.price - param2.price;
      }
      
      private function includeMisc() : Boolean
      {
         if(this.unitType == Unit.U_SPEARTON && this.currentItemType == MarketItem.T_ARMOR)
         {
            return true;
         }
         if(this.unitType == Unit.U_KNIGHT && this.currentItemType == MarketItem.T_ARMOR)
         {
            return true;
         }
         if(this.unitType == Unit.U_NINJA && this.currentItemType == MarketItem.T_WEAPON)
         {
            return true;
         }
         return false;
      }
      
      private function dontShowMisc() : Boolean
      {
         if(this.unitType == Unit.U_SPEARTON)
         {
            return true;
         }
         if(this.unitType == Unit.U_KNIGHT)
         {
            return true;
         }
         if(this.unitType == Unit.U_NINJA)
         {
            return true;
         }
         return false;
      }
      
      public function changeItemList() : void
      {
         var _loc1_:MarketItem = null;
         var _loc2_:Array = null;
         var _loc4_:MovieClip = null;
         var _loc5_:FrameLabel = null;
         var _loc6_:SFSObject = null;
         this.viewingIndex = 0;
         this.lastSentCount = 1000;
         for each(_loc1_ in this.currentItems)
         {
            if(this.displayContainer.contains(_loc1_))
            {
               displayContainer.removeChild(_loc1_);
            }
         }
         this.currentItems = [];
         _loc2_ = [];
         if(this.currentItemType != MarketItem.T_MISC || !this.dontShowMisc())
         {
            for each(_loc1_ in this.main.itemMap.getItems(this.unitType,this.currentItemType))
            {
               this.currentItems.push(_loc1_);
               _loc2_.push(_loc1_.name);
               _loc1_.setOldCard(this);
            }
         }
         var _loc3_:Array = [];
         if(this.includeMisc())
         {
            for each(_loc1_ in this.main.itemMap.getItems(this.unitType,MarketItem.T_MISC))
            {
               this.currentItems.push(_loc1_);
               _loc3_.push(_loc1_.name);
               _loc1_.setOldCard(this);
            }
         }
         this.currentItems.sort(this.sortOnCost);
         if(this.currentItemType != MarketItem.T_MISC || !this.dontShowMisc())
         {
            if((_loc4_ = ItemMap.getWeaponMcFromId(this._currentItemType,this.unitType)) != null && this.main.sfs.mySelf.getVariable("isAdmin").getIntValue() == 1 && this.main.armourScreen.isEditMode)
            {
               for each(_loc5_ in _loc4_.currentLabels)
               {
                  if(_loc2_.indexOf(_loc5_.name) == -1)
                  {
                     (_loc6_ = new SFSObject()).putInt("id",-1);
                     _loc6_.putUtfString("unit",ItemMap.unitTypeToName(this.unitType));
                     _loc6_.putUtfString("name",_loc5_.name);
                     _loc6_.putInt("type",this.currentItemType);
                     _loc6_.putUtfString("description","");
                     _loc6_.putUtfString("displayName",_loc5_.name);
                     _loc6_.putInt("price",-1);
                     trace(ItemMap.unitTypeToName(this.unitType),_loc5_.name);
                     _loc1_ = new MarketItem(_loc6_);
                     this.currentItems.unshift(_loc1_);
                     _loc1_.setOldCard(this);
                  }
               }
            }
         }
         if(this.includeMisc())
         {
            if((_loc4_ = ItemMap.getWeaponMcFromId(MarketItem.T_MISC,this.unitType)) != null && this.main.sfs.mySelf.getVariable("isAdmin").getIntValue() == 1 && this.main.armourScreen.isEditMode)
            {
               for each(_loc5_ in _loc4_.currentLabels)
               {
                  if(_loc3_.indexOf(_loc5_.name) == -1)
                  {
                     (_loc6_ = new SFSObject()).putInt("id",-1);
                     _loc6_.putUtfString("unit",ItemMap.unitTypeToName(this.unitType));
                     _loc6_.putUtfString("name",_loc5_.name);
                     _loc6_.putInt("type",MarketItem.T_MISC);
                     _loc6_.putUtfString("description","");
                     _loc6_.putUtfString("displayName",_loc5_.name);
                     _loc6_.putInt("price",-1);
                     _loc1_ = new MarketItem(_loc6_);
                     this.currentItems.unshift(_loc1_);
                     _loc1_.setOldCard(this);
                  }
               }
            }
         }
         this.itemPositionX = 0;
         this.itemPositionXReal = 600;
      }
      
      public function update() : void
      {
         var _loc3_:MarketItem = null;
         var _loc4_:MarketItem = null;
         var _loc5_:SFSObject = null;
         if(this.main.hasReceivedPurchases && this.lastSentCount++ > 1000)
         {
            for each(_loc4_ in this.currentItems)
            {
               if(_loc4_.price == 0 && this.main.purchases.indexOf(_loc4_.id) == -1)
               {
                  (_loc5_ = new SFSObject()).putInt("itemId",_loc4_.id);
                  this.main.sfs.send(new ExtensionRequest("buy",_loc5_));
               }
            }
            this.lastSentCount = 0;
         }
         this.itemMap[MarketItem.T_WEAPON] = this.main.loadout.getItem(this.unitType,MarketItem.T_WEAPON);
         this.itemMap[MarketItem.T_ARMOR] = this.main.loadout.getItem(this.unitType,MarketItem.T_ARMOR);
         this.itemMap[MarketItem.T_MISC] = this.main.loadout.getItem(this.unitType,MarketItem.T_MISC);
         this._unitMc.gotoAndStop(1);
         this.itemPositionX = -this.viewingIndex * 100;
         this.itemPositionXReal += (this.itemPositionX - this.itemPositionXReal) * 0.3;
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         for each(_loc3_ in this.currentItems)
         {
            _loc3_.update(this.main);
            if(!this.main.armourScreen.isUnlocking())
            {
               if(_loc3_.hitTestPoint(stage.mouseX,stage.mouseY,false))
               {
                  this.itemMap[_loc3_.type] = _loc3_.name;
                  _loc2_ = true;
               }
            }
            if(!this.displayContainer.contains(_loc3_))
            {
               displayContainer.addChild(_loc3_);
               this.itemPositionXReal += (this.itemPositionX - this.itemPositionXReal) * 1;
            }
            _loc3_.scaleX = 1;
            _loc3_.scaleY = 1;
            _loc3_.y = 10;
            _loc3_.x = this.itemPositionXReal + 123 + _loc1_ * 100;
            _loc1_++;
         }
         this.updateUnitProfile();
         if(this.hoverOverCard)
         {
            this.leftArrow.visible = true;
            this.rightArrow.visible = true;
         }
         else
         {
            this.leftArrow.visible = false;
            this.rightArrow.visible = false;
         }
         this.hoverOverCard = false;
      }
      
      public function select() : void
      {
         var _loc2_:MarketItem = null;
         this.isSelected = true;
         var _loc1_:String = this.main.loadout.getItem(this.unitType,this._currentItemType);
         for each(_loc2_ in this.currentItems)
         {
            if(_loc2_.name == _loc1_)
            {
               this.itemMap[this.currentItemType] = _loc2_.name;
               this.updateUnitProfile();
            }
         }
      }
      
      public function setSelected() : void
      {
         this.background.gotoAndStop(3);
         this.profileMc.gotoAndStop(3);
         this.select();
      }
      
      public function setHover() : void
      {
         this.hoverOverCard = true;
         this.background.gotoAndStop(2);
         this.profileMc.gotoAndStop(2);
      }
      
      public function setNotSelected() : void
      {
         this.background.gotoAndStop(1);
         this.profileMc.gotoAndStop(1);
         this.isSelected = false;
      }
      
      public function get isSelected() : Boolean
      {
         return this._isSelected;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         this._isSelected = param1;
      }
      
      public function get currentItemType() : int
      {
         return this._currentItemType;
      }
      
      public function set currentItemType(param1:int) : void
      {
         this._currentItemType = param1;
         this.changeItemList();
      }
      
      public function get unitType() : int
      {
         return this._unitType;
      }
      
      public function set unitType(param1:int) : void
      {
         this._unitType = param1;
      }
      
      public function get main() : Main
      {
         return this._main;
      }
      
      public function set main(param1:Main) : void
      {
         this._main = param1;
      }
      
      public function get currentItems() : Array
      {
         return this._currentItems;
      }
      
      public function set currentItems(param1:Array) : void
      {
         this._currentItems = param1;
      }
      
      public function get viewingIndex() : int
      {
         return this._viewingIndex;
      }
      
      public function set viewingIndex(param1:int) : void
      {
         this._viewingIndex = param1;
      }
   }
}
