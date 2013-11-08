// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery(function() {

    /////////////////////////////////
    /// MENU TABS PROFILE
    /////////////////////////////////

    var $navInfo = jQuery( '.nav-info' );
    var $lis = $navInfo.find( 'li' );
    var $aes = $navInfo.find( 'a' );
    var $containers = jQuery( "div.content-info > div" );

    $aes.click(function(event) {
        if (jQuery(this).parent().hasClass('active-info')) {
            return( false );
        }
        $lis.removeClass( 'active-info' );
        jQuery( this ).parent().addClass( 'active-info' );
        $containers.slideUp( 'fast' ).filter( this.hash ).slideDown( 'fast' );
        return( false );
    });

    //////////////////////////////////////////////////////////


    /////////////////////////////////
    /// AVATAR PREVIEW PICTURE
    /////////////////////////////////

    function onLoadAvatarTestHandler() {
        var jThis = jQuery( this );

        if ( jThis.attr( 'src' ) != '' ) {
            $avatarIcon.attr( { 'src' : jQuery.trim( $inputUrl.val() ) } );
            $avatarActions.slideDown( 'fast' );
            jThis.attr( { 'src' : '' } );
        }
    }

    function onErrorAvatarTestHandler() {
        var jThis = jQuery( this );

        if ( jThis.attr( 'src' ) != '' ) {
            $avatarIcon.attr( { 'src' : $originAvatar } );
            $alertUrl.show( 'fast' ).delay( 10000 ).hide( 'fast' );
            jThis.attr( { 'src' : '' } );
        }
    }
    
    var $defaultImageAvatar = '/assets/noavatar.png';

    var $radius = jQuery( 'div.avatar-settings input[type="radio"]' );
    var $defaultRadiusImage = jQuery( 'input#avatar-default[type="radio"]' );

    var $optionAvatar = jQuery( '.option-avatar' );
    var $originAvatar = jQuery( 'div.avatar-icon img' ).attr( 'src' );
    var $avatarIcon = jQuery( 'div.avatar-icon img' );
    var $avatarTest = jQuery( '<img>' );

    var $inputFile = jQuery( '.option-avatar input[type="file"]' );
    var $inputUrl = jQuery( '.option-avatar input[type="url"]' );
    var $btnPreview = jQuery( '.option-avatar button.preview' );
    var $alertUrl = jQuery( 'span.alert-url' );
    var $alertEmpty = jQuery( 'span.alert-empty' );

    var $avatarActions = $( 'div.avatar-actions' );

    $avatarTest
        .bind( 'load', onLoadAvatarTestHandler )
        .bind( 'error', onErrorAvatarTestHandler );


    $radius.change( function( event ) {
        $avatarIcon.attr( { 'src' : $originAvatar } );
        $avatarActions.slideUp( 'fast' );

        $optionAvatar.slideUp( 'fast' );
        $optionAvatar.children( 'input' ).attr( { 'disabled' : 'disabled' } );
        $inputUrl.val( '' );
        
        jQuery(this).parent().parent().find( '.option-avatar' ).children( 'input' ).removeAttr( 'disabled' );
        jQuery(this).parent().parent().find( '.option-avatar' ).slideDown( 'fast' );

        if ($defaultRadiusImage.is( ':checked' )) {
            $avatarIcon.attr( { 'src' : '/assets/noavatar.png' } );
            $avatarActions.slideDown( 'fast' );
        }
    });

    function previewImage( input ) {
        if ( input.files && input.files[ 0 ] ) {            
            var reader = new FileReader();

            reader.onload = function( e ) {
                $avatarIcon.attr( 'src', e.target.result );
            }

            reader.readAsDataURL( input.files[ 0 ] );
            $avatarActions.slideDown( 'fast' );
        } else if ( input.hasClass( 'preview' ) ) {
            var newSrc = jQuery.trim( $inputUrl.val() );

            if ( $avatarIcon.attr( 'src' ) != newSrc ) {
                $avatarActions.slideUp( 'fast' );
                $avatarIcon.attr( { 'src' : '/assets/loading.gif' } );
                $avatarTest.attr( { 'src' : newSrc } );
            }
        }
    }

    $inputFile.change(function() {
        previewImage( this );
    });

    $btnPreview.click(function( event ) {
        event.preventDefault();
        $alertUrl.hide( 'fast' );
        if ( $inputUrl.val() != '' ) {
            previewImage( jQuery( this ) );
        } else {
            $alertEmpty.show( 'fast' ).delay( 5000 ).hide( 'fast' );
        }
    });

    //////////////////////////////////////////////////////////
    

    /////////////////////////////////
    /// AVATAR PREVIEW PICTURE
    /////////////////////////////////
    
    function openWindow( url, title, w, h) {
        var popup = window.open( url, title, 'width='+w+', height='+h+', modal=no, resizable=no, toolbar=no, menubar=no,'+'scrollbars=no, alwaysRaise=yes' );
        popup.resizeBy( 0, 50 );
    }

    $btnTwitter = $( 'a[href="/auth/twitter"]' );

    $btnTwitter.click( function( event ) {
        event.preventDefault();
        openWindow( jQuery( this ).attr( 'href' ), jQuery( this ).html(), 880, 380 );
    });

    //////////////////////////////////////////////////////////

});
