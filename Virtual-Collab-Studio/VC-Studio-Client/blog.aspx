<%@ Page Title="blog" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="blog.aspx.cs" Inherits="VC_Studio_Client.blog" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center"
                style="background-color: #0D0F10; border-radius: 20px 20px 0px 0px;">
                <!-- Title -->
                <div class="d-flex align-items-center fw-bolder p-3">
                    <h5 class="text-white mb-0">Armstrong Number</h5>
                </div>
                <!-- Rating -->
                <div class="d-flex align-items-center">
                    <asp:Label ID="lblRating" runat="server" CssClass="text-white me-2">0.0</asp:Label>
                    <div class="ms-3">
                        <svg width="18" height="18" viewBox="0 0 18 18" fill="none"
                            xmlns="http://www.w3.org/2000/svg">
                            <path
                                d="M8.08094 1.64069C8.42102 0.786437 9.57934 0.786437 9.91943 1.64069L11.4 5.35972C11.5434 5.71985 11.8676 5.96591 12.2397 5.99708L16.0827 6.31896C16.9655 6.39289 17.3234 7.54381 16.6509 8.1457L13.7229 10.7661C13.4393 11.0198 13.3155 11.4179 13.4021 11.7973L14.2967 15.7153C14.5022 16.6152 13.5651 17.3265 12.8093 16.8443L9.51914 14.7447C9.20053 14.5414 8.79983 14.5414 8.48123 14.7447L5.19104 16.8443C4.43529 17.3265 3.4982 16.6152 3.70367 15.7153L4.59822 11.7973C4.68485 11.4179 4.56102 11.0198 4.27749 10.7661L1.34949 8.1457C0.676938 7.54381 1.03488 6.39289 1.91762 6.31896L5.76067 5.99708C6.13281 5.96591 6.45698 5.71985 6.60035 5.35972L8.08094 1.64069Z"
                                stroke="#686B6E" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                        </svg>
                    </div>
                </div>
            </div>
            <div class="card-body w-100 h-75">
                <div class="ms-2">
                    <div class="card-body d-flex flex-wrap align-items-stretch">
                        <!-- Code Editor Section -->
                        <div class="col-md-6 pe-md-3 d-flex flex-column">
                            <div class="code-editor mt-3"
                                style="position: relative; border-radius: 12px;">
                                <header
                                    style="display: flex; justify-content: space-between; align-items: center; background-color: #191919; border-radius: 12px 12px 0 0;">
                                    <h5 style="margin: 0; color: white;"></h5>
                                    <button class="btn btn-sm" style="color: #686B6E;"
                                        onclick="copyToClipboard(this)">
                                        <svg width="18" height="18" viewBox="0 0 18 18" fill="none"
                                            xmlns="http://www.w3.org/2000/svg">
                                            <path
                                                d="M14.5 6H15C16.1046 6 17 6.89543 17 8V15C17 16.1046 16.1046 17 15 17H8C6.89543 17 6 16.1046 6 15V14.5M3 12H10C11.1046 12 12 11.1046 12 10V3C12 1.89543 11.1046 1 10 1H3C1.89543 1 1 1.89543 1 3V10C1 11.1046 1.89543 12 3 12Z"
                                                stroke="#686B6E" stroke-width="1.5"
                                                stroke-linecap="round" stroke-linejoin="round" />
                                        </svg>
                                        Copy Code
                                    </button>
                                </header>
                                <div>
                                    <pre>
                                                        <code style="color: #686B6E;">
1. import React, { useState } from 'react';
2. 
3. const ArmstrongChecker = () => {
4.     const [number, setNumber] = useState("");
5.     const [result, setResult] = useState("");
6. 
7.     const isArmstrong = (num) => {
8.         const digits = num.split("").map(Number);
9.         const power = digits.length;
10.        const sum = digits.reduce((acc, digit) => acc + Math.pow(digit, power), 0);
11.        return sum === Number(num);
12.    };
13. 
14.    const handleCheck = () => {
15.        if (!number) {
16.            setResult("Enter a number.");
17.        } else if (isArmstrong(number)) {
18.            setResult(\`\${number} is an Armstrong!\`);
19.        } else {
20.            setResult(\`\${number} is not an Armstrong!\`);
21.        }
22.    };
23. 
24.    return (
25.        // Your JSX code here
26.    );
27. };
                                                        </code>
                                                    </pre>
                                </div>

                                <footer
                                    style="background-color: #191919; color: white; border-radius: 0 0 12px 12px; text-align: center; padding: 10px;">
                                </footer>
                            </div>


                        </div>
                        <!-- Accordion Section -->
                        <div class="col-md-6 mt-3 d-flex flex-column">

                            <!-- Description Accordion -->
                            <div class="accordion-container" style="flex-grow: 1; display: flex; flex-direction: column;">
                                <div class="accordion" id="accordionDescription">
                                    <div class="accordion-item" style="border-radius: 20px;">
                                        <h2 class="accordion-header" id="headingDescription" style="border-radius: 20px;">
                                            <button class="accordion-button" type="button" style="border-radius: 20px 20px 0px 0px;"
                                                data-bs-toggle="collapse"
                                                data-bs-target="#collapseDescription"
                                                aria-expanded="true"
                                                aria-controls="collapseDescription">
                                                <i class="bi bi-chevron-down accordion-icon"></i>
                                                <span class="ms-2">Description</span>
                                            </button>
                                        </h2>
                                        <div id="collapseDescription"
                                            class="accordion-collapse collapse show"
                                            aria-labelledby="headingDescription"
                                            data-bs-parent="#accordionDescription">
                                            <div class="accordion-body">
                                                Program to check if a given number N is an Armstrong
                                                            number. If N is an Armstrong number, print "Yes,"
                                                            otherwise print "No."
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Review Accordion -->
                                <div class="accordion" id="accordionReview" style="border-radius: 0px 0px 22px 22px;">
                                    <div class="accordion-item" style="border-radius: 0px 0px 22px 22px;">
                                        <h2 class="accordion-header" id="headingReview" style="border-radius: 0px 0px 22px 22px;">
                                            <button class="accordion-button" type="button" style="border-radius: 0px 0px 22px 22px;"
                                                data-bs-toggle="collapse"
                                                data-bs-target="#collapseReview" aria-expanded="true"
                                                aria-controls="collapseReview">
                                                <i class="bi bi-chevron-down accordion-icon"></i>

                                                <span class="ms-2">Review</span>
                                            </button>
                                        </h2>
                                        <div id="collapseReview"
                                            class="accordion-collapse collapse show" style="border-radius: 0px 0px 22px 22px;"
                                            aria-labelledby="headingReview"
                                            data-bs-parent="#accordionReview">
                                            <div class="accordion-body">
                                               <ul id="reviewsList" class="list-unstyled" runat="server">
                                                    
                                                    
                                                    
                                                    <li class="d-flex align-items-center p-3">
                                                        <button
                                                            class="btn d-flex align-items-center text-light" data-bs-toggle="modal"
                                                            data-bs-target="#addreviewmodal"
                                                            style="background-color: #0D0F10; border-color: #0D0F10; margin: auto; padding: revert-layer;">
                                                            <svg width="20" height="20"
                                                                viewBox="0 0 20 20" fill="none"
                                                                xmlns="http://www.w3.org/2000/svg">
                                                                <path
                                                                    d="M10 6V10M10 10V14M10 10H14M10 10H6M19 10C19 14.9706 14.9706 19 10 19C5.02944 19 1 14.9706 1 10C1 5.02944 5.02944 1 10 1C14.9706 1 19 5.02944 19 10Z"
                                                                    stroke="#686B6E" stroke-width="1.5"
                                                                    stroke-linecap="round" />
                                                            </svg>

                                                            <span class="ms-2"
                                                                style="color: #686B6E; font-size: 14px;">Add
                                                                            Review</span>
                                                        </button>

                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AfterSection" runat="server">
    <div class="modal fade" id="addreviewmodal" tabindex="-1" aria-labelledby="addreviewmodalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addreviewmodalLabel">Rate This Post!</h5>

                    <button type="button" class="btn-close" style="filter: invert(1);" data-bs-dismiss="modal"
                        aria-label="Close">
                    </button>

                </div>
                <div class="modal-body">
                    <span style="color: #9B9C9E; font-size: 14px;">Rate this post to provide feedback and guide the community toward valuable content.</span>
                    <div class="input-field mt-2 d-flex flex-column align-items-start">
                        <!-- Label -->
                        <label for="rating" class="mb-2" style="color: #9B9C9E; font-size: 14px;">Set Your Rating</label>

                        <!-- Rating Field (Stars) -->
                        <div id="rating" class="d-flex align-items-center justify-content-center p-2 w-100">
            <!-- 5 star rating system -->
            <span class="star" data-value="1">&#9733;</span>
            <span class="star" data-value="2">&#9733;</span>
            <span class="star" data-value="3">&#9733;</span>
            <span class="star" data-value="4">&#9733;</span>
            <span class="star" data-value="5">&#9733;</span>
        </div>
                         <input type="hidden" id="ratingValue" name="ratingValue" value="0">

                        <!-- Cancel and Submit Buttons -->
                        <div class="mt-2 d-flex justify-content-center w-100">
                            <button class="btn gradient-button" type="button" style="border-radius: 12px;">
                                Cancel
                            </button>
                            <asp:Linkbutton type="button" class="btn btn-sm ms-3 text-center" onclick="SubmitRating" runat="server"
                                style="background-color: #7DEA4D; color: #0C1132; border-color: #7DEA4D; height: 3rem; border-radius: 12px;">
                                Submit
                            
                                <svg width="35" height="33" viewBox="0 0 35 33" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <rect x="0.5" y="0.5" width="34" height="32" rx="12" fill="#1C1C1E" />
                                    <path
                                        d="M17.3 7.5L20.3593 13.0227L26.3 14.3754L22.25 19.1413L22.8624 25.5L17.3 22.9227L11.7377 25.5L12.35 19.1413L8.30005 14.3754L14.2408 13.0227L17.3 7.5Z"
                                        fill="#7DEA4D" />
                                </svg>


                            </asp:Linkbutton>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
    <style>
    .star {
        font-size: 30px;
        color: #CCCCCC;
        cursor: pointer;
        transition: color 0.3s ease;
    }

    .star:hover,
    .star.active {
        color: #FFD700;
    }
</style>

<script>
    const stars = document.querySelectorAll('.star');
    const ratingValueInput = document.getElementById('ratingValue');
    const submitRatingButton = document.getElementById('submitRating');

    stars.forEach((star, index) => {
        star.addEventListener('click', () => {
            // Update active class
            stars.forEach((s, i) => {
                s.classList.toggle('active', i <= index);
            });

            // Set the value of the hidden input
            ratingValueInput.value = index + 1;
            console.log('Rating selected:', ratingValueInput.value); // For debugging
        });
        const stars = document.querySelectorAll('.star');
        const ratingValueInput = document.getElementById('ratingValue');

        stars.forEach(star => {
            star.addEventListener('click', () => {
                const rating = star.getAttribute('data-value');
                ratingValueInput.value = rating;

                stars.forEach(s => s.classList.remove('active'));
                for (let i = 0; i < rating; i++) {
                    stars[i].classList.add('active');
                }
            });
        });


        star.addEventListener('mouseover', () => {
            // Highlight stars on hover
            stars.forEach((s, i) => {
                s.classList.toggle('active', i <= index);
            });
        });

        star.addEventListener('mouseout', () => {
            // Reset highlight to current rating value
            const currentRating = ratingValueInput.value;
            stars.forEach((s, i) => {
                s.classList.toggle('active', i < currentRating);
            });
        });
    });

    // Handle rating submission
    submitRatingButton.addEventListener('click', () => {
        const rating = ratingValueInput.value;
        if (rating > 0) {
            alert(`Thank you for rating this post: ${rating} stars!`);
            // Submit the rating (e.g., via AJAX or form submission)
            // Example: console.log('Submit rating to server:', rating);
        } else {
            alert('Please select a rating before submitting.');
        }
    });
</script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="footer" runat="server">
    <script>
        function copyToClipboard(button) {
            const codeElement = document.querySelector('pre code');
            const codeText = codeElement.textContent;
            navigator.clipboard.writeText(codeText)
                .then(() => {
                    button.textContent = 'Copied'; // Update button text to 'Copied'
                    const svgIcon = button.querySelector('svg');
                    svgIcon.style.display = 'none'; // Hide the SVG icon
                    setTimeout(() => {
                        button.textContent = 'Copy Code'; // Reset button text after 2 seconds
                        svgIcon.style.display = 'block'; // Show the SVG icon again
                    }, 2000); // Reset after 2 seconds
                })
                .catch(err => {
                    console.error('Failed to copy code: ', err);
                });
        }

    </script>
    <!-- ======= Footer ======= -->
    <a href="#" class="back-to-top d-flex align-items-center justify-content-center gradient-button"><i
        class="bi bi-arrow-up-short"></i></a>
</asp:Content>
