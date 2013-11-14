// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery( function() {

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
            $alertUrl.show( 'fast' );
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

    var $inputTwitter = jQuery( 'input#avatar-twitter' );
    var $inputFacebook = jQuery( 'input#avatar-facebook' );
    var $inputGoogle = jQuery( 'input#avatar-google' );
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
        
        jQuery( this ).parent().parent().find( '.option-avatar' ).children( 'input' ).removeAttr( 'disabled' );
        jQuery( this ).parent().parent().find( '.option-avatar' ).slideDown( 'fast' );

        if ( $defaultRadiusImage.is( ':checked' ) ) {
            $avatarIcon.attr( { 'src' : '/assets/noavatar.png' } );
            $avatarActions.slideDown( 'fast' );
        }

        if ( $inputTwitter.is( ':checked' ) ) {
            var src = $inputTwitter.parent().parent().find( '.option-avatar' ).children( 'input' ).attr( 'value' );
            $inputTwitter.parent().parent().find( '.option-avatar' ).hide();
            $avatarIcon.attr( { 'src' : src } )
            $avatarActions.slideDown( 'fast' );
        }

        if ( $inputFacebook.is( ':checked' ) ) {
            var src = $inputFacebook.parent().parent().find( '.option-avatar' ).children( 'input' ).attr( 'value' );
            $inputFacebook.parent().parent().find( '.option-avatar' ).hide();
            $avatarIcon.attr( { 'src' : src } )
            $avatarActions.slideDown( 'fast' );
        }

        if ( $inputGoogle.is( ':checked' ) ) {
            var src = $inputGoogle.parent().parent().find( '.option-avatar' ).children( 'input' ).attr( 'value' );
            $inputGoogle.parent().parent().find( '.option-avatar' ).hide();
            $avatarIcon.attr( { 'src' : src } )
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
        $alertEmpty.hide( 'fast' );
        if ( $inputUrl.val() != '' ) {
            previewImage( jQuery( this ) );
        } else {
            $alertEmpty.show( 'fast' ).delay( 3000 ).hide( 'fast' );
            return( false )
        }
    });

    //////////////////////////////////////////////////////////
    

    /////////////////////////////////
    /// AVATAR PREVIEW PICTURE
    /////////////////////////////////
    
    function openWindow( url, title, w, h) {
        var popup = window.open( url, title, 'width='+w+', height='+h+', modal=no, resizable=no, toolbar=no, menubar=no,'+'scrollbars=no, alwaysRaise=yes' );
        // popup.resizeBy( 0, 50 );
    }

    $btnTwitter = $( 'a[ href="/auth/twitter" ]' );
    $btnFacebook = $( 'a[ href="/auth/facebook" ]' );
    $btnGoogle = $( 'a[ href="/auth/google_oauth2" ]' );

    $btnTwitter.click( function( event ) {
        event.preventDefault();
        openWindow( jQuery( this ).attr( 'href' ), jQuery( this ).html(), 880, 380 );
    });

    $btnFacebook.click( function( event ) {
        event.preventDefault();
        openWindow( jQuery( this ).attr( 'href' ), jQuery( this ).html(), 880, 380 );
    });

    $btnGoogle.click( function( event ) {
        event.preventDefault();
        openWindow( jQuery( this ).attr( 'href' ), jQuery( this ).html(), 880, 380 );
    });

    //////////////////////////////////////////////////////////
    

    /////////////////////////////////
    /// FORM PROFILE BASIC INFO
    /////////////////////////////////

    var $EditProfileInfo = $( "button#edit-profile-btn" );
    var $BackProfileInfo = $( "button#back-profile-btn" );
    var $formProfile = $( "div.profile-form" );
    var $infoProfile = $( "div.profile-info" );

    $EditProfileInfo.click( function() {
        $infoProfile.hide( 'fast' );
        $formProfile.slideDown( 'fast' );
    });

    $BackProfileInfo.click( function( event ) {
        event.preventDefault();
        $infoProfile.slideDown( 'fast' );
        $formProfile.slideUp( 'fast' );
    });

    //////////////////////////////////////////////////////////


    /////////////////////////////////
    /// FORM ACCOUNT INFO
    /////////////////////////////////

    var $EditAccountInfo = $( "button#edit-account-btn" );
    var $BackAccountInfo = $( "button#back-account-btn" );
    var $BackAccountPassword = $( "button#back-password-btn" );
    var $btnChangePassword = $( "button#btn-password" );
    var $formAccount = $( "div.account-form" );
    var $passwordAccount = $( "div.account-password" );
    var $infoAccount = $( "div.account-info" );

    var $editPasswordUserForm = $( "form.edit_password_user" );
    var $editPasswordUserFormBtn = $( "form.edit_password_user input[ type='submit' ]" );
    var $inputPassword = $editPasswordUserForm.children( 'div.block-info' ).children( 'input[ id*="user_password" ]' );
    var $alertInputPassword = $editPasswordUserForm.children( 'div.block-info' ).children( 'input[ id*="user_password" ]' ).parent().children( 'span.alert-password');
    var $inputPasswordConfirmation = $editPasswordUserForm.children( 'div.block-info' ).children( 'input[ id*="user_password_confirmation" ]' );

    alert($alertInputPassword.attr('class'));

    $EditAccountInfo.click( function() {
        $passwordAccount.hide();
        $infoAccount.hide( 'fast' );
        $formAccount.slideDown( 'fast' );
    });

    $btnChangePassword.click( function() {
        $formAccount.hide();
        $infoAccount.hide( 'fast' );
        $passwordAccount.slideDown( 'fast' );
    });

    $BackAccountInfo.click( function( event ) {
        event.preventDefault();
        $infoAccount.slideDown( 'fast' );
        $formAccount.slideUp( 'fast' );
        $passwordAccount.hide();
    });

    $BackAccountPassword.click( function( event ) {
        event.preventDefault();
        $infoAccount.slideDown( 'fast' );
        $passwordAccount.slideUp( 'fast' );
        $formAccount.hide();
    });

    $editPasswordUserFormBtn.click( function( event ) {
        event.preventDefault();
        if ( $inputPassword.val() === $inputPasswordConfirmation.val() ) {
            $editPasswordUserForm.submit();
        } else {
            alert('incorrecto');
        }
    });

    $inputPassword.change( function( event ) {
        if ( $inputPassword.val().length < 8 ) {
            alert('short');
        }
    });

    //////////////////////////////////////////////////////////

});
