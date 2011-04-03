$(function() {
	
	$( 'div[class|="hud"]' ).after( '<div class="shadow">&nbsp;</div>' );

	
	$( '.ps' ).append( '<span class="return"></span>' );
	$( '.ps' ).parent().find( '.body' ).append( '<p class="ui-ps">Read note</p>' );
	$( '.ui-ps' ).hide();
	$( '.player-info' ).hide();
	
	$( '.ui-ps' ).click( function() {
		 $( this ).parents( 'div.post' ).find( 'div.ps' ).show( 'blind', { direction: 'vertical' }, 200 );
		 $( this ).fadeOut(100);
	});
	$( '.return' ).click( function() {
		$( this ).parents( 'div.post' ).find( '.ui-ps' ).fadeIn(100);
		$( this ).parent().hide( 'blind', { direction: 'vertical' }, 200 );
	});
	
	$( 'a[name="expand"]' ).click( function() {
			$( '.ps' ).show( 'slide', { direction: 'up' }, 200 );
			$( '.ui-ps' ).fadeOut(100);
	});
	$( 'a[name="collapse"]' ).click( function() {
			$( '.ps' ).hide( 'slide', { direction: 'up' }, 200 );
			$( '.ui-ps' ).fadeIn(100);
	});
	
	$( '.player-info' ).parent( 'h1' ).hover(
						function() { $( this ).find( '.player-info' ).show(); },
						function() { $( this ).find( '.player-info' ).delay(250).fadeOut(125); });

	function toggleHUD( hud ) {
		hud.toggle( 'blind', { direction: 'vertical' }, 250 );
	};
	
	$( '.hud-write #hud-body' ).hide();
	$( '.hud-write .body' ).addClass( 'expandable' );
	$( '.hud-party #hud-body' ).hide();
	$( '.hud-party .body' ).addClass( 'expandable' );
	
	$( 'div[class|="hud"] h1' ).click( function(){
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
                $( this ).hide();
                $( 'textarea#ooc' ).show();
  });
  
  $( '.post form' ).textSaver();
  
});