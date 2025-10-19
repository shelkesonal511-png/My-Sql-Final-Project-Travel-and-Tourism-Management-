# Travel & Tourism Management Database (TravelTourismDB)

## 📖 Introduction
The **Travel & Tourism Management Database** is designed to streamline the operations of travel agencies, tour operators, and hospitality providers.  
It centralizes customer information, bookings, flights, hotels, destinations, guides, activities, and payments into one integrated system.

### 🌍 Real-world Applications
- **Centralized Management** – Manage customers, agents, bookings, and payments efficiently.  
- **Package Creation** – Build and sell customized travel packages (destinations, hotels, transport, activities).  
- **Resource Allocation** – Assign guides, vehicles, and staff to tours.  
- **Financial Tracking** – Monitor customer payments, refunds, and loyalty points.  
- **Business Insights** – Generate reports on revenue, top destinations, and seasonal trends.  

This system is similar to what powers companies like **Expedia, MakeMyTrip, TripAdvisor, Airbnb**, etc.

---

## 🏗️ Database Design

### 📌 List of Tables (25 Total)
Each table has **10 attributes** with constraints (PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, DEFAULT).  

1. **Countries** (country_id, country_name, iso_code, region, currency, phone_code, population, language, created_at, updated_at)  
2. **Cities** (city_id, city_name, country_id, population, area_km2, airport_code, postal_code, is_capital, created_at, updated_at)  
3. **Destinations** (destination_id, city_id, name, type, description, rating, entry_fee, opening_hours, closing_hours, created_at)  
4. **Hotels** (hotel_id, destination_id, name, star_rating, address, contact_number, email, total_rooms, price_range, created_at)  
5. **HotelRooms** (room_id, hotel_id, room_type, capacity, price_per_night, availability, amenities, bed_type, view, created_at)  
6. **Flights** (flight_id, airline, source_city_id, dest_city_id, departure_time, arrival_time, duration_hours, price, seats_available, status)  
7. **FlightSeats** (seat_id, flight_id, seat_no, class, is_available, price, passenger_name, booking_id, created_at, updated_at)  
8. **Customers** (customer_id, first_name, last_name, email, phone, nationality, dob, passport_no, created_at, loyalty_points)  
9. **Agents** (agent_id, name, email, phone, agency_name, license_no, rating, address, created_at, commission_rate)  
10. **Packages** (package_id, package_name, agent_id, description, start_city_id, end_city_id, duration_days, max_people, price_per_person, created_at)  
11. **PackageItems** (item_id, package_id, item_type, ref_id, day_no, sequence_no, notes, included, price_addon, created_at)  
12. **Bookings** (booking_id, customer_id, package_id, booking_date, travel_date, total_price, status, payment_status, created_at, updated_at)  
13. **Payments** (payment_id, booking_id, method, amount, status, transaction_id, currency, paid_at, refunded, created_at)  
14. **Reviews** (review_id, customer_id, package_id, rating, comments, review_date, approved, created_at, updated_at)  
15. **Activities** (activity_id, destination_id, activity_name, activity_type, duration_minutes, price, min_age, max_participants, operator_name, created_at)  
16. **ActivityBookings** (act_booking_id, activity_id, customer_id, booking_date, participants, total_cost, status, created_at, updated_at, notes)  
17. **CarRentals** (rental_id, customer_id, vehicle_id, pickup_date, return_date, price_per_day, total_price, status, created_at, updated_at)  
18. **RentalVehicles** (vehicle_id, model, brand, type, seats, transmission, fuel_type, price_per_day, availability, created_at)  
19. **TourGuides** (guide_id, name, email, phone, language, experience_years, rating, availability, location, created_at)  
20. **GuideAssignments** (assignment_id, guide_id, package_id, start_date, end_date, role, status, created_at, updated_at, notes)  
21. **Itineraries** (itinerary_id, package_id, day_no, title, description, start_time, end_time, location, notes, created_at)  
22. **ItineraryItems** (item_id, itinerary_id, activity_id, type, description, start_time, end_time, price, included, created_at)  
23. **LoyaltyPrograms** (program_id, customer_id, points_earned, points_redeemed, level, start_date, end_date, created_at, updated_at, status)  
24. **Coupons** (coupon_id, code, discount_type, discount_value, valid_from, valid_to, min_purchase, max_discount, usage_limit, created_at)  
25. **Notifications** (notification_id, customer_id, type, message, status, sent_at, read_at, created_at, updated_at, priority, sender)  

---

## 📸 Results

## 📈 Analysis

The database allows efficient management of customers, bookings, and payments.

Provides insights on most popular destinations, seasonal demand, and revenue.

Helps agencies manage resources like guides, vehicles, and hotel rooms.

Enhances customer satisfaction with loyalty programs and coupons.

## 📝 Reflection
✅ Challenges:

Designing 25 tables without redundancy (normalization).

Handling multiple relationships with foreign keys.

Populating 20 realistic records per table.

💡 Solutions:

Applied PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, DEFAULT constraints.

Normalized the schema (3NF) to remove duplication.

Wrote sample inserts with logical relationships (customer → booking → payment).
