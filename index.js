// function to parse url
function parseUrl(url) {
  // parse the url into a URL object
  const urlObj = new URL(url);
  // create a new object to store the query parameters
  const query = {};
  // loop through the searchParams object of the URL object
  for (const [key, value] of urlObj.searchParams) {
    // if the key doesn't exist in the query object, create an array with the value
    if (!query[key]) {
      query[key] = [value];
    } else {
      // if the key already exists, push the value to the array
      query[key].push(value);
    }
  }
  // return the query object
  return query;
}

query = parseUrl('http://localhost:8080/test?name=John&name=Jane&age=30');

console.log(query);

function splitURLandReturnComponents(url) {
  const urlObj = new URL(url);
  return {
    protocol: urlObj.protocol,
    host: urlObj.host,
    hostname: urlObj.hostname,
    port: urlObj.port,
    pathname: urlObj.pathname,
    search: urlObj.search,
    hash: urlObj.hash,
  };
}

obj = splitURLandReturnComponents('http://localhost:8080/test?name=John&name=Jane&age=30#heading');

console.log(obj);