/*!CK:1190830530!*//*1401173968,178167347*/

if (self.CavalryLogger) { CavalryLogger.start_js(["mGZZD"]); }

__d("OGCollectionAddDialog",["AsyncRequest","DataStore","DOMQuery","Form","MenuDeprecated","URI","collectDataAttributes","copyProperties","csx","tidyEvent"],function(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p){var q='OGCollectionAddDialog';function r(s,t,u,v,w){this._dialog=s;this._surface=t;this._endpoint=l(v);this._loadEditMenu=w.loadEditMenu;this._listener=h.get(String(u),q);this._audienceSelector=i.find(this._dialog.getContent(),'.audienceSelector');this._menu=i.find(this._dialog.getContent(),"._4-jt");k.register(this._menu);this._menuSubscriptionToken=k.subscribe('select',this._onMenuClick.bind(this));p([this._dialog.subscribe('show',this._onDialogShow.bind(this)),this._dialog.subscribe('hide',this._onDialogHide.bind(this))]);if(w.setContextToParent)this._dialog.setContext(this._dialog.getContext().parentNode);this._dialog.show();}n(r,{INSTANCE_KEY:q});n(r.prototype,{_onDialogShow:function(){this._listener.onDialogShow(this._dialog);},_onDialogHide:function(){this._destroy();},_onMenuClick:function(s,t){if(t.menu!==this._menu)return;var u=t.item;this._listener.onMenuClick(u);var v=i.find(u,"._5581"),w=v.getAttribute('value');this._submitRequest(w);},_submitRequest:function(s){this._endpoint.addQueryData({collection_token:s});this._dialog.hide();this._request=new g(this._endpoint).setData(n(j.serialize(this._audienceSelector),{action:'add',load_edit_menu:this._loadEditMenu,surface:this._surface},m(this._dialog.getContext(),['ft'])));this._request.send();},_destroy:function(){this._listener.onDialogHide();k.unsubscribe(this._menuSubscriptionToken);}});e.exports=r;},null);
__d("OGCollectionAddMenu",["CSS","DataStore","DOM","DOMQuery","Event","OGCollectionAddDialog","Parent","TidyArbiterMixin","copyProperties","csx","cx","tidyEvent"],function(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r){function s(t,u,v,w,x,y){this._image=u;this._container=v;this._placeholder=w;this._surface=x;this._rateControl=i.scry(this._container.parentNode,"._5fza")[0];s.inform('addButton',{button:this._image,root:this._container});r(k.listen(this._container,'click',function(z){var aa=m.byClass(z.getTarget(),"_5859");if(this.isDialogShowing()&&aa)z.kill();}.bind(this)));if(this._surface==='friend_timeline_lhc')this._handleAlwaysVisibleLHC();h.set(String(t),l.INSTANCE_KEY,this);}o(s,n);o(s.prototype,n,{destroy:function(){i.remove(this._container);this._placeholder.destroy();},hide:function(){g.hide(this._image);this._placeholder.hide();},getParent:function(){return this._container.parentNode;},insertMenuIntoDialog:function(t){this._placeholder.insertIntoDialog(t);},onMenuClick:function(t){var u=j.find(t,"._5582");this._showRate=this._rateControl&&u.getAttribute('value');if(this._showRate){this.switchToShowRate();k.fire(this._rateControl,'click');}else this._switchToShowPlaceholder();this.inform('menuclicked');},onDialogShow:function(t){var u=j.find(t.getContent(),'.audienceSelector');g.addClass(this._image,'openToggler');s.inform('menuOpened',{audienceSelector:u.parentNode});this._dialogShowing=true;},onDialogHide:function(){g.removeClass(this._image,'openToggler');this._dialogShowing=false;},isDialogShowing:function(){return this._dialogShowing;},_switchToShowPlaceholder:function(){g.hide(this._image);g.show(this._placeholder.getIcon());},switchToShowRate:function(){g.hide(this._image);g.show(this._rateControl);},_handleAlwaysVisibleLHC:function(){var t=m.byClass(this._container,"_4_ij"),u=m.byClass(t,"_5-r");if(g.hasClass(t,"_58v0"))r([this._alwaysVisibleToken=k.listen(u,'mouseenter',function(){g.removeClass(t,"_58v0");this._alwaysVisibleToken.remove();}.bind(this))]);}});e.exports=s;},null);
__d("OGCollectionAddedIconPlaceholder",["CSS","DataStore","DOM","DOMQuery","Event","copyProperties","csx","tidyEvent"],function(a,b,c,d,e,f,g,h,i,j,k,l,m,n){var o='OGCollectionAddedIconPlaceholder';function p(q,r,s,t){this._dialog=s;this._icon=r;this._addPlaceholder=t;n(k.listen(r,'click',s.show.bind(s)));h.set(String(q),o,this);}l(p,{loadEditMenu:function(q,r){var s=h.get(String(q),o);s.insertIntoDialog(r);}});l(p.prototype,{destroy:function(){this._dialog.destroy();},getIcon:function(){return this._icon;},hide:function(){g.hide(this._icon);g.show(this._addPlaceholder);this._dialog.hide();},insertIntoDialog:function(q){i.setContent(j.find(this._dialog.getContent(),"._51rr"),q);}});e.exports=p;},null);
__d("OGCollectionAddedIconRate",["DataStore","Event","copyProperties","tidyEvent"],function(a,b,c,d,e,f,g,h,i,j){var k='OGCollectionAddedIconRate';function l(m,n){this._link=m;g.set(String(n),k,this);}l.disable=function(m){var n=g.get(String(m),k);n._disable();};i(l.prototype,{_disable:function(){j(h.listen(this._link,'click',function(m){m.kill();}));}});e.exports=l;},null);