$(function() {
	
	$( '.GUI.write' ).after( '<div class="shadow">&nbsp;</div>' );

	
	$( '.ps' ).append( '<span class="return"></span>' );
	$( '.ps' ).parent().find( '.body' ).append( '<p class="ui-ps">Read note</p>' );
	$( '.ui-ps' ).hide();
	$( '.info' ).hide();
  
  $( '.bar' ).hide();
  $( '.bar' ).parents( '.post' ).find( '.body h1' ).click( function() {
      toggleHUD( $( this ).parents( '.post' ).find( '.bar' ) );
  });
	
	$( '.ui-ps' ).click( function() {
		 $( this ).parents( 'div.post' ).find( 'div.ps' ).show( 'blind', { direction: 'vertical' }, 200 );
		 $( this ).fadeOut(100);
	});
	$( '.return' ).click( function() {
		$( this ).parents( 'div.post' ).find( '.ui-ps' ).fadeIn(100);
		$( this ).parent().hide( 'blind', { direction: 'vertical' }, 200 );
	});
  
	$( '.info' ).parents( '.post' ).hover(
						function() { $( this ).find( '.info' ).show(); },
						function() { $( this ).find( '.info' ).delay(150).fadeOut(125); });

	function toggleHUD( hud ) {
		hud.toggle( 'blind', { direction: 'vertical' }, 250 );
	};
	
	$( '.GUI.write #hud-body' ).hide();
	$( '.GUI.write .body' ).addClass( 'expandable' );
	$( '.GUI.party #hud-body' ).hide();
	$( '.GUI.party .body' ).addClass( 'expandable' );
	
	$( '.GUI h1' ).click( function(){
								toggleHUD( $( this ).siblings( 'div[id="hud-body"]' ) );
								$( this ).parent( '.body' ).toggleClass( 'expandable collapsable' );
	});

  $( '#writeto-list' ).hide();
  $( '#writeto-all' ).change( function() {
                $( this ).delay(300).fadeOut(200);
                $( '#writeto-list' ).delay(600).fadeIn(200);
  });
  
  $( 'textarea#ooc' ).hide();
  $( '#ooc' ).click( function() {
                $( this ).delay(100).fadeOut(200);
                $( 'textarea#ooc' ).delay(300).show( 'blind', { direction: 'vertical' }, 300 );
  });
  
  $( '.post form' ).textSaver();
  
});