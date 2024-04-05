# API Endpoint

- **Endpoint:** `/api/taxi/availability`
- **Method:** GET
- **Parameters:**
  - `latitude` (required): Latitude of the location.
  - `longitude` (required): Longitude of the location.
  - `radius` (optional): Search radius in meters (default is set if not provided).
- **Response:** An array of taxi objects containing details such as ID, driver name, license plate, and availability status.

## Sample Request

```http
GET /api/taxi/availability?latitude=37.7749&longitude=-122.4194&radius=1000