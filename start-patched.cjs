const dns = require('dns');
const origLookup = dns.lookup;
dns.lookup = function(hostname, options, callback) {
  if (typeof options === 'function') { callback = options; options = {}; }
  if (typeof options === 'number') options = { family: options };
  if (hostname === 'api.telegram.org' || hostname.endsWith('.telegram.org')) {
    if (options.all) { callback(null, [{ address: '149.154.167.220', family: 4 }]); }
    else { callback(null, '149.154.167.220', 4); }
    return;
  }
  return origLookup.call(dns, hostname, options, callback);
};
process.env.TELEGRAM_BOT_TOKEN = '8334624520:AAGx5Xsj18Tsyw7Y7NH3Ic8nZi3DNj9SNPE';
process.env.LOG_LEVEL = 'info';
require('./dist/index.js');
