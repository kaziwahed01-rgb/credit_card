# Credit Card Demo

A Flutter demo that shows a credit card preview above a payment form.  
As the user types, the card preview updates in real time. When the CVV field is focused, the card flips to the back.

This README is written as an interview guide, so it explains not only what the app does, but also why the code is structured this way and how to talk about it clearly.

## 1. Project Summary

### What this app does

- Shows a live credit card preview
- Updates card number, card holder, expiry, and CVV in real time
- Highlights the active field on the card preview
- Flips the card when the CVV field is focused
- Validates input at the UI level:
  - Card number: digits only, max 16 digits
  - Card holder: letters and spaces only
  - CVV: digits only, max 3 digits

### What this project demonstrates

- Flutter UI composition
- State management with `flutter_bloc`
- Clean separation between UI, state, and shared helpers
- Real-time form interaction
- Animation driven by state

## 2. How To Explain This Project In An Interview

You can explain it in one short flow:

1. The form captures credit card details.
2. The UI sends user actions to a `Bloc`.
3. The `Bloc` updates a single `CardFormState`.
4. The card preview rebuilds from that state.
5. Focus state also lives in the `Bloc`, so highlighting and card flip are controlled centrally.

Short interview version:

> "This is a Flutter credit card form demo. I used Bloc so the UI stays simple and all state changes go through one state object. When the user types or changes focus, the Bloc updates the state, and the preview rebuilds automatically."

## 3. Project Structure

```text
lib/
  main.dart
  src/
    core/
      theme/
      utils/
    domain/
      entities/
    presentation/
      bloc/
      pages/
      widgets/
test/
  widget_test.dart
```

### What each layer does

#### `main.dart`

- App entry point
- Provides the `CardFormBloc`
- Sets theme and starts the page

#### `src/core`

- Shared code used across the app
- `theme/`: colors, text styles, and UI theme
- `utils/`: formatting helpers like card-number masking

#### `src/domain`

- Contains the main business entity: `CreditCardEntity`
- Represents the card data shown in the preview

#### `src/presentation`

- Everything related to UI and state management
- `bloc/`: state, events, and Bloc logic
- `pages/`: screen-level widget
- `widgets/`: reusable UI pieces like form fields and card display

## 4. Why I Used Bloc Here

### Reason

This app has multiple connected UI behaviors:

- form input
- card preview update
- focused-field highlighting
- card flip animation
- submit feedback

If I kept all of that inside widgets with `setState`, the code would become harder to follow as the app grows.

### Why Bloc is a good fit

- Keeps the source of truth in one place
- Makes UI widgets mostly dumb/presentational
- Makes it easier to explain data flow
- Scales better if later I add API calls, persistence, or validation rules

### Why this Bloc is simple

I intentionally kept the Bloc small:

- one state object
- one main "change" event
- one submit event
- helper methods like `updateCardNumber()` and `focusField()` so the UI is easy to read

That gives me Bloc structure without unnecessary ceremony.

## 5. State Flow

### Main state object

The app uses `CardFormState`.

It stores:

- `cardData`
- `submissionCount`
- `lastSubmittedCardNumber`
- `focusedField`

### Important concept

`isFlipped` is derived from `focusedField`.

That means:

- if focused field is `cvv`, the card flips
- otherwise, it stays on the front

This is a good interview point because it shows I reduced duplicated state.

Short explanation:

> "I avoided storing separate mutable UI flags where I could derive them from existing state. The card flip is determined by which field is focused."

## 6. Event And Update Flow

The UI does not mutate data directly.

Example flow for card number:

1. User types in the card number field
2. Widget calls `bloc.updateCardNumber(value)`
3. Bloc adds a `CardFormChanged` event
4. Bloc sanitizes and formats the value
5. New `CardFormState` is emitted
6. Preview rebuilds with updated number

Same pattern is used for:

- card holder
- expiry month/year
- CVV
- focused field
- submit action

## 7. Important Files To Know

### [main.dart](./lib/main.dart)

What to say:

> "This file wires the app together. It creates the Bloc and injects it into the widget tree using `BlocProvider`."

### [card_form_bloc.dart](./lib/src/presentation/bloc/card_form_bloc.dart)

What to say:

> "This is the heart of the app state. It handles all form changes, sanitizes input, updates the card data, and emits the next state."

Important points:

- input sanitization happens here too, not only in the widget
- state updates are centralized
- submit logic is simple and easy to extend

### [card_form_state.dart](./lib/src/presentation/bloc/card_form_state.dart)

What to say:

> "This holds the current UI state. I kept it immutable, and every update produces a new state object."

### [credit_card_page.dart](./lib/src/presentation/pages/credit_card_page.dart)

What to say:

> "This page is stateless. It listens to Bloc state and composes the preview and form sections."

This is a strong point:

- page-level widget does not own mutable state
- animation behavior is driven from Bloc state

### [credit_card_display.dart](./lib/src/presentation/widgets/credit_card_display.dart)

What to say:

> "This widget renders the card front/back and uses Bloc-driven state to decide highlighting and flipping."

Important points:

- `TweenAnimationBuilder` handles the card flip
- focus rectangle is calculated based on the selected field
- preview stays separate from form input widgets

### [card_form_section.dart](./lib/src/presentation/widgets/card_form_section.dart)

What to say:

> "This widget contains the actual form controls and forwards user actions to the Bloc."

### [card_validation_utils.dart](./lib/src/core/utils/card_validation_utils.dart)

What to say:

> "I extracted formatting logic into a utility so the Bloc stays readable and formatting rules are reusable."

## 8. Input Validation Strategy

I used two levels of validation/sanitization.

### UI-level restriction

Using input formatters:

- card number: digits only, max 16
- card holder: letters and spaces only
- CVV: digits only, max 3

### Bloc-level safety

The Bloc sanitizes values again before saving them in state.

Why this is good:

- UI prevents most invalid input
- Bloc still protects app state
- logic is safer if input source changes later

Good interview answer:

> "I use defense in depth. The UI restricts bad input early, and the Bloc sanitizes again before state is updated."

## 9. Animation Explanation

### Card flip

The card flips when `focusedField == CardFormField.cvv`.

The display widget uses `TweenAnimationBuilder` to animate between:

- `0` for front
- `1` for back

Why I chose this:

- simpler than managing an `AnimationController` in the page
- page stays stateless
- animation is fully driven by Bloc state

Good answer:

> "I moved the flip logic to state-driven animation so the page itself doesn't hold animation state."

## 10. UI Decisions

### Card highlight

The preview highlights the currently focused field:

- card number
- card holder
- expiry

Why:

- gives immediate visual feedback
- creates a stronger connection between form and preview

### Black border with grey shadow

I used that for the focus rectangle so the highlight is visible on the textured card background without looking too heavy.

## 11. Why The Page Is Stateless

This is a very good interview topic.

You can say:

> "I made `CreditCardPage` stateless because the app state already lives in Bloc. The page only listens and renders. That makes the screen easier to test, reason about, and explain."

Benefits:

- less widget-local complexity
- better separation of concerns
- easier to maintain

## 12. Testing

Current test:

- basic widget test that checks the main form labels render

What to say honestly:

> "I added a smoke test for the main screen. If I had more time, I would also add Bloc tests for input changes and flip behavior."

That is a strong answer because it shows realism.

## 13. Tradeoffs I Made

### What I kept simple

- no backend
- no persistence
- no advanced payment validation
- no repository/data-source layer because it would be unnecessary for this feature set

### Why that is reasonable

This app is a UI/state-management demo.  
Adding fake complexity would make the architecture heavier without adding value.

Good answer:

> "I kept the architecture proportional to the problem. I used layering where it helped clarity, but I avoided adding unused abstractions."

## 14. Common Interview Questions And Good Answers

### Q: Why did you use Bloc instead of `setState`?

Answer:

> "Because multiple UI elements depend on the same state: the form, the preview, the field highlight, and the card flip. Bloc gives me a single source of truth and keeps the screen easier to scale."

### Q: Why is there a domain entity?

Answer:

> "The domain entity represents the card data independently of the widgets. It keeps the state model clean and lets UI rebuild from a consistent data object."

### Q: Why not use Cubit?

Answer:

> "Cubit would also work here, but I kept Bloc because I wanted explicit event-driven updates while still keeping the event model small and easy to follow."

### Q: How does the card flip work?

Answer:

> "The flip is derived from focus state. When the focused field becomes CVV, the state reports `isFlipped = true`, and the preview animates to the back using `TweenAnimationBuilder`."

### Q: How do you prevent invalid input?

Answer:

> "I restrict input in the text fields with formatters and sanitize again in the Bloc before updating state."

### Q: What would you improve next?

Answer:

> "I would add dedicated Bloc unit tests, improve card-brand detection, and add more robust validation like Luhn checking and expiry validation."

## 15. Improvements I Would Make If This Were Production

- Add Bloc unit tests
- Add card brand detection
- Add Luhn validation
- Add expiry-date validation against current month/year
- Add accessibility improvements
- Persist form data if needed
- Add better error messaging

## 16. How To Run

```bash
flutter pub get
flutter run
```

## 17. How To Demo It Live

If asked to show the app:

1. Type a card number and show the preview updating
2. Type a card holder name and mention text-only restriction
3. Open expiry and show the expiry highlight
4. Focus CVV and show the card flip
5. Press submit and show the snackbar

That gives a complete walkthrough in under one minute.

## 18. Final Interview Summary

If you want one clean closing statement, use this:

> "This project is a Flutter credit card form demo built with Bloc. I used a single immutable state object, centralized updates in the Bloc, kept the page stateless, and made the preview react in real time to form input and focus. My goal was to keep the code scalable but still easy to understand and explain."
