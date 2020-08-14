# FAN-RELATIONAL_DB-PROJECT2
Project 2 of relational database

Practicum Setup Notes
• You are to create a package called practicum2_pkg that contains 1 procedure
and two functions to dump out order information based on orders that a
particular customer has created (Projects Workspace). Your project
workspace must be functional to do this practicum.
• You’ll execute the package’s procedure against a particular customer id, you can
use the CustomerId ERNSH for testing purposes. During the practicum you’ll be
instructed to use a different customer.
• The initial package specification is as follows:
• To get the initial desired output (see page 4):
1. Get the date by issuing a SELECT sysdate FROM dual).
2. Retrieve’s the company’s name from the function get_cust_name
3. The procedure should issue a more complicated query. It should produce
the OrderId, OrderDate, an indicator whether or not the order shipped, and
a total amount (total qty * price less discount for each item in the order).
You’ll need to use a number of different functions and techniques
(including a Cursor) to get this one to come out correctly. Also ensure if
there is a discount amount, apply it.
4. The last line’s data in the sample on page 4 should be calculated by the
function get_avg_order_amount.
• All money fields are to be represented in currency format (use TO_CHAR ).
• You have 90 minutes in next week’s class to include 2 additional functions that
will be given at the start. You are to work on your own to incorporate them into 
the existing code, when finished, submit the specification and body code and the
results of executing the package.
• Next week’s video will be a final exam review
Here is the initial output from the package’s procedure that you should complete prior to
entering the practicum:
