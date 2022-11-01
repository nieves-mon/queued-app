// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener("DOMContentLoaded", () => {
    addListenerToCheckbox();
    addListenerToDropdown();

    document.addEventListener("click", () => {
        addListenerToCheckbox();
    })

    document.addEventListener("change", () => {
        addListenerToDropdown();
    })
})

function addListenerToCheckbox() {
    const checkboxes = document.querySelectorAll('.task-check');
    const forms = document.querySelectorAll('.task-check-form');

    checkboxes.forEach((checkbox, i) => {
        checkbox.addEventListener("change", () => {
            forms[i].submit();
        })
    })
}

function addListenerToDropdown() {
    const dropdownBtns = document.querySelectorAll('.dropdown-btn');
    const taskGroups = document.querySelectorAll('.tasks-group');

    dropdownBtns.forEach((dropdownBtn, i) => {
        dropdownBtn.addEventListener("click", () => {
            dropdownBtn.classList.toggle("hidden");
            taskGroups[i].classList.toggle("hidden");
        })
    })
}
