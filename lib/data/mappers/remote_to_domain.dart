import 'package:domain/models/party.dart';
import 'package:domain/models/platform.dart';
import 'package:domain/models/ticket.dart';
import 'package:domain/models/user.dart';
import 'package:mepaga_ai/data/remote/models/party_rm.dart';
import 'package:mepaga_ai/data/remote/models/platform_rm.dart';
import 'package:mepaga_ai/data/remote/models/ticket_rm.dart';
import 'package:mepaga_ai/data/remote/models/user_rm.dart';

extension UserRMMappers on UserRM {
  User toDM() => User(
        name: name,
        email: email,
        pixKey: pixKey,
      );
}

extension TicketRMMappers on TicketRM {
  Ticket toDM() => Ticket(
        sellerId: sellerId,
        price: price,
        sold: sold,
        party: party?.toDM(),
        id: id,
      );
}

extension PartyRMMappers on PartyRM {
  Party toDM() => Party(
        name: name,
        date: date,
        description: description,
        picture: picture,
      );
}

extension PlatformRMMappers on PlatformRM {
  Platform toDM() => Platform(
        platform: platform,
        associated: associated,
      );
}
