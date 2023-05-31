
// API Methods to implement;
abstract class APIMethods {
  get(String url);
  post(String url, Map bodyData);
  put(String url, Map bodyData);
  delete(String url, Map bodyData);
}