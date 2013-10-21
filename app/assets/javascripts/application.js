// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.autosize
//= require posts

function linkHome() { location.href="/"; }

$(document).trigger('initialize:frame');

function categories() {
    $("nav#categories").toggleClass('active');
    $("section#global-wrapper").toggleClass('active-categories');
    return( false );
}

function hideCategories() {
    if ($("nav#categories").hasClass('active')) {
        $("nav#categories").removeClass('active');
        $("section#global-wrapper").removeClass('active-categories');
    }
}

$(function() {
	$("section#wrapper").click(function() {
		hideCategories();
	});

    $("footer").click(function() {
        hideCategories();
    });

    $('div.textarea textarea').autosize();

    $('div.textarea textarea').focus(function() {
        $('div.commenter').show('fast');
    });

    $('div.textarea textarea').blur(function() {
        if (!commentStat) {
            $('div.commenter').hide('fast');
        }
    });

    $('div.form-comment form input[type="text"]').blur(function() {
        if (!commentStat) {
            $('div.commenter').hide('fast');
        }
    });

    $('div.form-comment form').mouseover(function() {
        commentStat = true;
    }).mouseout(function() {
        commentStat = false;        
    });
});