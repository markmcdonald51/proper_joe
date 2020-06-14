// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

const importAll = (r) => r.keys().map(r)
importAll(require.context('images', false, /\.(png|jpe?g|svg)$/i));
//importAll(require.context('@fortawesome/fontawesome-free/webfonts', false, /\.(eot|svg|ttf|woff2?)$/i));

import "core-js/stable";
import "regenerator-runtime/runtime";
import "@stimulus/polyfills";

// import JQuery from 'jquery';
// window.$ = window.JQuery = JQuery;

import "bootstrap";
import "@coreui/coreui"

import "stylesheets/application"

require("@rails/ujs").start()
require("turbolinks").start()
//require("@rails/activestorage").start()
require("channels")

import "turbolinks/coreui";
import "controllers";


require("datatables.net-bs4")
require("chartkick")
require("chart.js")

import 'select2'
import 'select2/dist/css/select2.css'
// import 'popper.js/dist/esm/popper'

//window.addEventListener('DOMContentLoaded', () => {
document.addEventListener("turbolinks:load", ()  => {
  $('.select2').select2()
})

document.addEventListener("turbolinks:load", ()  => {
  $('.datatable').DataTable();
});


import JQuery from 'jquery';
window.$ = window.JQuery = JQuery;
global.$ = jQuery;

Chartkick.configure({language: "en", mapsApiKey: "AIzaSyAXYKxXDt9JiiELFw1aKFPwHJFJrqMdSXo"})

